class Donation
  include ActiveModel::Validations
  attr_accessor :amount_dollars

  @@show = false

  validates :amount_dollars, presence: true, format: /\A\d*\.?\d{0,2}\z/


  def initialize(params)
    @amount_dollars = params[:amount_dollars].to_f
  end

  def amount_cents
    (@amount_dollars * 100).to_i
  end

  def self.show_toggle
    @@show = !@@show
  end

  def self.show
    @@show
  end
end
