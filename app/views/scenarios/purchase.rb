class Views::Scenarios::Purchase < Views::Layouts::Page
  needs :scenario
  needs :payment_url

  def main
    h1 "Purchase #{scenario.name}"
    link_to 'Pay now', payment_url, class: 'mainLink'
  end
end
