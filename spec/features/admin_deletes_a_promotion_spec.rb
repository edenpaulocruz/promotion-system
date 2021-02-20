require 'rails_helper'

feature 'Admin deletes a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Apagar')
  end
    
  scenario 'sucessfully' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'
    click_on 'Apagar'
    
    expect(current_path).to eq(promotions_path)
    expect(page).to have_content('Nenhuma promoção cadastrada')
  end
end