require "rails_helper"
describe GuestsController do

  let!(:event) { FactoryBot.create(:event) }

  context "as a guest" do
    describe "#new" do
      it "creates a new guest called @guest" do
        get :new, params: { event_id: event.id }
        expect(assigns(:guest)).not_to be_nil
        expect(assigns(:guest)).to be_a_new(Guest)
      end
    end

    context "for a free event" do
      let!(:event) { FactoryBot.create(:free_event) }

      describe "#create" do
        it "adds a guest" do
          expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: event.id }
          }.to change { Guest.count }.by(1)
        end

        it "sends a confirmation email" do
          expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: event.id }
          }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end

        it "creates a mailer job" do
          ActiveJob::Base.queue_adapter = :test
          expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: event.id }
          }.to have_enqueued_job.on_queue('mailers')
        end

        context "invalid attributes" do
          it "re-renders new template" do
            post :create, params: { guest: FactoryBot.attributes_for(:invalid_guest), event_id: event.id }
            expect(response).to render_template("new")
          end

          it "does not add a new guest" do
            expect { post :create, params: { guest: FactoryBot.attributes_for(:invalid_guest), event_id: event.id }
            }.to change { Guest.count }.by(0)
          end
        end

        context "when the event is a full event" do
          let!(:full_event) { FactoryBot.create(:full_event) }

          it "re-renders new template" do
            post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: full_event.id }
            expect(response).to render_template("new")
          end

          it "does not add a new guest" do
            expect { post :create, params: { guest: FactoryBot.attributes_for(:guest), event_id: full_event.id } }
          end
        end
      end
    end

    context "for a paid event" do
      let!(:event) { FactoryBot.create(:event) }

      it "adds a guest" do
        card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
        expect { post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token,
                                         first_name: "Test", last_name: "guest", email: "test@guest.com",
                                         occupation: "Other", department: "Other", gender: "Other", event_id: event.id }
        }.to change { Guest.count }.by(1)
      end

      it "sends a confirmation email" do
        card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
        expect { post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token,
                                         first_name: "Test", last_name: "guest", email: "test@guest.com",
                                         occupation: "Other", department: "Other", gender: "Other", event_id: event.id }
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "creates a mailer job" do
        ActiveJob::Base.queue_adapter = :test
        card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
        expect { post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token,
                                         first_name: "Test", last_name: "guest", email: "test@guest.com",
                                         occupation: "Other", department: "Other", gender: "Other", event_id: event.id }
        }.to have_enqueued_job.on_queue('mailers')
      end

      context "invalid card" do
        it "re-renders new template" do
          StripeMock.prepare_card_error(:card_declined)
          card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
          post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token,
                                  firstname: "Test", lastname: "guest", email: "test@guest.com",
                                  occupation: "Other", department: "Other", gender: "Other", event_id: event.id }
          expect(response).to render_template("new")
        end

        it "does not add a new guest" do
          StripeMock.prepare_card_error(:card_declined)
          card_token = StripeMock.generate_card_token(last4: "4242", exp_year: 3001)
          expect { post :create, params: { stripeEmail: "someone@fake.com", stripeToken: card_token,
                                           firstname: "Test", lastname: "guest", email: "test@guest.com",
                                           occupation: "Other", department: "Other", gender: "Other", event_id: event.id }
          }.to change { Guest.count }.by(0)
        end
      end
    end


    describe "#destroy" do
      let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }

      it "cannot delete a guest as user" do
        expect { delete :destroy, params: { id: guest.id, event_id: event.id }
        }.to change { Guest.count }.by(0)
      end
    end
  end


  context "as an admin" do
    let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }
    login_admin
    describe "#destroy" do
      it "deletes a guest as admin" do
        expect { delete :destroy, params: { id: guest.id, event_id: event.id }
        }.to change { Guest.count }.by(-1)
      end

      it "redirects to index" do
        delete :destroy, params: { id: guest.id, event_id: event.id }
        expect(response).to redirect_to(event_path(event))
      end
    end
  end
end
