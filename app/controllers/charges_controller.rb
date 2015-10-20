include Amount

class ChargesController < ApplicationController
  def downgrade
    current_user.standard!

    current_user.wiki_entries.each do |entry|
      entry.private = false;
      entry.save
    end

    redirect_to edit_user_registration_path
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "Premium account for #{current_user.email}",
      currency: 'usd'
    )

    current_user.premium!

    flash[:notice] = "You have upgraded to a premium account."
    redirect_to wiki_entries_path # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium account for #{current_user.name}",
      amount: Amount.default
    }
  end

end
