require "application_system_test_case"

class ModelHousesTest < ApplicationSystemTestCase
  setup do
    @model_house = model_houses(:one)
  end

  test "visiting the index" do
    visit model_houses_url
    assert_selector "h1", text: "Model houses"
  end

  test "should create model house" do
    visit model_houses_url
    click_on "New model house"

    check "Aircon" if @model_house.aircon
    check "Balcony" if @model_house.balcony
    check "Cableprov" if @model_house.cableprov
    check "Carport" if @model_house.carport
    check "Cctv" if @model_house.cctv
    check "Cityview" if @model_house.cityview
    check "Clubhouse" if @model_house.clubhouse
    check "Conveniencestore" if @model_house.conveniencestore
    check "Coveredcourt" if @model_house.coveredcourt
    check "Crfixtures" if @model_house.crfixtures
    fill_in "Description", with: @model_house.description
    check "Dirtykitchen" if @model_house.dirtykitchen
    check "Drainagesystem" if @model_house.drainagesystem
    check "Facingeast" if @model_house.facingeast
    check "Firesystem" if @model_house.firesystem
    fill_in "Furnish type", with: @model_house.furnish_type
    check "Garden" if @model_house.garden
    check "Gate" if @model_house.gate
    check "Guardhouse" if @model_house.guardhouse
    check "Homecctv" if @model_house.homecctv
    check "Homepool" if @model_house.homepool
    check "Inherit amenities" if @model_house.inherit_amenities
    check "Intercom" if @model_house.intercom
    check "Internetprov" if @model_house.internetprov
    check "Joggingpaths" if @model_house.joggingpaths
    check "Lanai" if @model_house.lanai
    check "Landscaping" if @model_house.landscaping
    check "Lightfixtures" if @model_house.lightfixtures
    check "Meterperunit" if @model_house.meterperunit
    check "Modkitchen" if @model_house.modkitchen
    check "Mountainview" if @model_house.mountainview
    check "Parks" if @model_house.parks
    check "Perimeterfence" if @model_house.perimeterfence
    check "Petfriendly" if @model_house.petfriendly
    check "Playground" if @model_house.playground
    check "Pool" if @model_house.pool
    fill_in "Price", with: @model_house.price
    check "Provaircon" if @model_house.provaircon
    check "Smarthomeready" if @model_house.smarthomeready
    fill_in "Title", with: @model_house.title
    check "Undergroundlines" if @model_house.undergroundlines
    check "Wardrobes" if @model_house.wardrobes
    check "Washingmachineprov" if @model_house.washingmachineprov
    check "Wastemgmt" if @model_house.wastemgmt
    check "Waterheaterprov" if @model_house.waterheaterprov
    check "Watersystem" if @model_house.watersystem
    check "Watertank" if @model_house.watertank
    click_on "Create Model house"

    assert_text "Model house was successfully created"
    click_on "Back"
  end

  test "should update Model house" do
    visit model_house_url(@model_house)
    click_on "Edit this model house", match: :first

    check "Aircon" if @model_house.aircon
    check "Balcony" if @model_house.balcony
    check "Cableprov" if @model_house.cableprov
    check "Carport" if @model_house.carport
    check "Cctv" if @model_house.cctv
    check "Cityview" if @model_house.cityview
    check "Clubhouse" if @model_house.clubhouse
    check "Conveniencestore" if @model_house.conveniencestore
    check "Coveredcourt" if @model_house.coveredcourt
    check "Crfixtures" if @model_house.crfixtures
    fill_in "Description", with: @model_house.description
    check "Dirtykitchen" if @model_house.dirtykitchen
    check "Drainagesystem" if @model_house.drainagesystem
    check "Facingeast" if @model_house.facingeast
    check "Firesystem" if @model_house.firesystem
    fill_in "Furnish type", with: @model_house.furnish_type
    check "Garden" if @model_house.garden
    check "Gate" if @model_house.gate
    check "Guardhouse" if @model_house.guardhouse
    check "Homecctv" if @model_house.homecctv
    check "Homepool" if @model_house.homepool
    check "Inherit amenities" if @model_house.inherit_amenities
    check "Intercom" if @model_house.intercom
    check "Internetprov" if @model_house.internetprov
    check "Joggingpaths" if @model_house.joggingpaths
    check "Lanai" if @model_house.lanai
    check "Landscaping" if @model_house.landscaping
    check "Lightfixtures" if @model_house.lightfixtures
    check "Meterperunit" if @model_house.meterperunit
    check "Modkitchen" if @model_house.modkitchen
    check "Mountainview" if @model_house.mountainview
    check "Parks" if @model_house.parks
    check "Perimeterfence" if @model_house.perimeterfence
    check "Petfriendly" if @model_house.petfriendly
    check "Playground" if @model_house.playground
    check "Pool" if @model_house.pool
    fill_in "Price", with: @model_house.price
    check "Provaircon" if @model_house.provaircon
    check "Smarthomeready" if @model_house.smarthomeready
    fill_in "Title", with: @model_house.title
    check "Undergroundlines" if @model_house.undergroundlines
    check "Wardrobes" if @model_house.wardrobes
    check "Washingmachineprov" if @model_house.washingmachineprov
    check "Wastemgmt" if @model_house.wastemgmt
    check "Waterheaterprov" if @model_house.waterheaterprov
    check "Watersystem" if @model_house.watersystem
    check "Watertank" if @model_house.watertank
    click_on "Update Model house"

    assert_text "Model house was successfully updated"
    click_on "Back"
  end

  test "should destroy Model house" do
    visit model_house_url(@model_house)
    click_on "Destroy this model house", match: :first

    assert_text "Model house was successfully destroyed"
  end
end
