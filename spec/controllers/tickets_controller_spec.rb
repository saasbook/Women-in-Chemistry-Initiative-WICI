require "rails_helper"
describe TicketsController do
  describe "#check" do
    let!(:event) { FactoryBot.create(:event) }
    let!(:guest) { FactoryBot.create(:guest, event_id: event.id) }
    let!(:ticket) { FactoryBot.create(:ticket, guest_id: guest.id) }
    it "renders 'approved' if good ticket" do
      get :check, params: { code: ticket.code, event_id: event.id, guest_id: guest.id }
      expect(response).to render_template("approved")
    end

    it "renders 'approved' if bad ticket" do
      get :check, params: { code: "bad", event_id: event.id, guest_id: guest.id }
      expect(response).to render_template("denied")
    end
  end
end