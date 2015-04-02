class Views::Payments::Products::Index < Views::Layouts::Page
  needs :current_user

  def main
    current_user.scenarios.includes(:product).each do |scenario|
      product = scenario.product || Payments::Product.new
      div scenario.name
      form_for product do |f|
        f.hidden_field :purchasable_id, value: scenario.id
        f.hidden_field :purchasable_type, value: scenario.class
        f.label :price, "Price"
        f.text_field :price
        button_tag 'Make Sellable', class: 'edit'
      end
    end
  end
end
