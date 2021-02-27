require 'rails_helper'

feature 'Admin inactivates a coupon' do
  scenario 'successfully' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                      expiration_date: '22/12/2033')
    #promotion.generate_coupons!
    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Inativar'

    coupon.reload
    expect(page).to have_content('NATAL10-0001 (Inativo)')
    expect(coupon).to be_inactive #inactive?
  end

  scenario 'does not view button' do
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 1,
                      expiration_date: '22/12/2033')
    inactive_coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion, status: :inactive)
    active_coupon = Coupon.create!(code: 'NATAL10-0002', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(page).to have_content('NATAL10-0001 (Inativo)')
    expect(page).to have_content('NATAL10-0002 (Ativo)')
    
    within("div#coupon-#{active_coupon.id}") do
      expect(page).to have_link 'Inativar'
    end

    within("div#coupon-#{inactive_coupon.id}") do
      expect(page).not_to have_link 'Inativar'
    end
  end
end