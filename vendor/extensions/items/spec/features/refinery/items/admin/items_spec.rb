# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Items" do
    describe "Admin" do
      describe "items" do
        refinery_login_with :refinery_user

        describe "items list" do
          before do
            FactoryGirl.create(:item, :model => "UniqueTitleOne")
            FactoryGirl.create(:item, :model => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.items_admin_items_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.items_admin_items_path

            click_link "Add New Item"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Model", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Items::Item.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Model can't be blank")
              Refinery::Items::Item.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:item, :model => "UniqueTitle") }

            it "should fail" do
              visit refinery.items_admin_items_path

              click_link "Add New Item"

              fill_in "Model", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Items::Item.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:item, :model => "A model") }

          it "should succeed" do
            visit refinery.items_admin_items_path

            within ".actions" do
              click_link "Edit this item"
            end

            fill_in "Model", :with => "A different model"
            click_button "Save"

            page.should have_content("'A different model' was successfully updated.")
            page.should have_no_content("A model")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:item, :model => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.items_admin_items_path

            click_link "Remove this item forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Items::Item.count.should == 0
          end
        end

      end
    end
  end
end
