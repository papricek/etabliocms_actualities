# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Actualities', '' do

  background do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  scenario 'Some crud for admin' do
    click_link('Novinky (0)')
    page.should have_content('Novinky')
    click_link('Přidat novinku »')
    click_button('Uložit')
    page.should have_content('Nadpis je povinná položka')
    fill_in 'Nadpis', :with => 'A title with české znaky ěščřžýáíé'
    click_button('Uložit')
    page.should have_content('Novinka byla úspěšně vytvořena.')
    actuality = EtabliocmsActualities::Actuality.last
    actuality.title.should == 'A title with české znaky ěščřžýáíé'
    actuality.slug.should == 'a-title-with-ceske-znaky-escrzyaie'
    click_link(actuality.title)
    fill_in 'Nadpis', :with => 'Change!'
    click_button('Uložit')
    page.should have_content('Novinka byla úspěšně upravena.')
    actuality.reload.title.should == "Change!"
  end

end
