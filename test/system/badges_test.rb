require "application_system_test_case"

class BadgesTest < ApplicationSystemTestCase
  setup do
    @badge = badges(:one)
  end

  test "visiting the index" do
    visit badges_url
    assert_selector "h1", text: "Badges"
  end

  test "creating a Badge" do
    visit badges_url
    click_on "New Badge"

    fill_in "Active", with: @badge.active
    fill_in "Badge type", with: @badge.badge_type_id
    fill_in "Object", with: @badge.object_id
    fill_in "Object type", with: @badge.object_type
    click_on "Create Badge"

    assert_text "Badge was successfully created"
    click_on "Back"
  end

  test "updating a Badge" do
    visit badges_url
    click_on "Edit", match: :first

    fill_in "Active", with: @badge.active
    fill_in "Badge type", with: @badge.badge_type_id
    fill_in "Object", with: @badge.object_id
    fill_in "Object type", with: @badge.object_type
    click_on "Update Badge"

    assert_text "Badge was successfully updated"
    click_on "Back"
  end

  test "destroying a Badge" do
    visit badges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Badge was successfully destroyed"
  end
end
