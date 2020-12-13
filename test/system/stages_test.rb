require "application_system_test_case"

class StagesTest < ApplicationSystemTestCase
  setup do
    @stage = stages(:one)
  end

  test "visiting the index" do
    visit stages_url
    assert_selector "h1", text: "Stages"
  end

  test "creating a Stage" do
    visit stages_url
    click_on "New Stage"

    check "Done" if @stage.done
    fill_in "End", with: @stage.end
    fill_in "Name", with: @stage.name
    fill_in "Start", with: @stage.start
    fill_in "Task", with: @stage.task_id
    click_on "Create Stage"

    assert_text "Stage was successfully created"
    click_on "Back"
  end

  test "updating a Stage" do
    visit stages_url
    click_on "Edit", match: :first

    check "Done" if @stage.done
    fill_in "End", with: @stage.end
    fill_in "Name", with: @stage.name
    fill_in "Start", with: @stage.start
    fill_in "Task", with: @stage.task_id
    click_on "Update Stage"

    assert_text "Stage was successfully updated"
    click_on "Back"
  end

  test "destroying a Stage" do
    visit stages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stage was successfully destroyed"
  end
end
