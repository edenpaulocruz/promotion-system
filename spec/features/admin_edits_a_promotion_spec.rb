require 'rails_helper'

feature 'Admin edits a promotion' do
  scenario 'from index page' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_link('Editar')
  end
    
  scenario 'and attributes cannot be blank' do
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'
    click_on 'Editar'
    fill_in 'Código', with: 'CYBER20'
    fill_in 'Desconto', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Desconto não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'
    click_on 'Editar'
    fill_in 'Código', with: 'NATAL10'
    fill_in 'Desconto', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('Código já está em uso')
  end

  scenario 'successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    
    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'
    click_on 'Editar'
    fill_in 'Código', with: 'CYBER20'
    fill_in 'Desconto', with: '20'
    click_on 'Enviar'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('20,00%')
    expect(page).to have_content('CYBER20 ')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('100')
    expect(page).to have_link('Voltar')
  end
end