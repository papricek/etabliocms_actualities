# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Categories', '' do

  background do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  scenario 'Some crud for admin' do
    click_link('Kategorie (0)')
    page.should have_content('Kategorie')
    click_link('Přidat kategorii »')
    click_button('Uložit')
    page.should have_content('Nadpis je povinná položka')
    fill_in 'Nadpis', :with => 'A title with české znaky ěščřžýáíé'
    click_button('Uložit')
    page.should have_content('Kategorie byla úspěšně vytvořena.')
    category = EtabliocmsActualities::Category.last
    category.title.should == 'A title with české znaky ěščřžýáíé'
    category.slug.should == 'a-title-with-ceske-znaky-escrzyaie'
    click_link(category.title)
    fill_in 'Nadpis', :with => 'Change!'
    click_button('Uložit')
    page.should have_content('Kategorie byla úspěšně upravena.')
    category.reload.title.should == "Change!"
  end

  scenario 'Moving categories in hierarchy via edit' do
    root = FactoryGirl.create(:category)
    first_child = FactoryGirl.create(:category, :child_of => root.id)
    second_child = FactoryGirl.create(:category, :child_of => root.id)
    first_child.parent.should == root
    second_child.parent.should == root
    visit admin_homepage
    click_link('Kategorie (3)')
    click_link(first_child.title)
    page.should have_content(first_child.title)
    select 'Nejvyšší úroveň', :from => 'Rodič'
    click_button('Uložit')
    page.should have_content('Kategorie byla úspěšně upravena.')
    first_child.reload.parent.should be_nil
    click_link(first_child.title)
    select root.title, :from => 'Rodič'
    click_button('Uložit')
    page.should have_content('Kategorie byla úspěšně upravena.')
    first_child.reload.parent.should == root
  end

  scenario 'Moving categories in hierarchy via arrows' do
    root = FactoryGirl.create(:category)
    first_child = FactoryGirl.create(:category, :child_of => root.id)
    second_child = FactoryGirl.create(:category, :child_of => root.id)
    root.children.first.should == first_child
    visit admin_homepage
    click_link('Kategorie (3)')
    find(:xpath, "//a[@href='/admin/categories/#{first_child.id}/move?method=move_lower']").click
    page.should have_content('Kategorie byla úspěšně přesunuta.')
    root.children.reload.first.should == second_child
    page.driver.put("/admin/categories/#{first_child.id}/move?method=move_to_bottom")
    root.children.reload.first.should == second_child
    find(:xpath, "//a[@href='/admin/categories/#{second_child.id}/move?method=move_to_bottom']").click
    page.should have_content('Kategorie byla úspěšně přesunuta.')
    root.children.reload.first.should == first_child
  end

end
