require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    @listing = listings(:one)
  end

  test "visiting the index" do
    visit listings_url
    assert_selector "h1", text: "Listings"
  end

  test "should create listing" do
    visit listings_url
    click_on "New listing"

    fill_in "Address", with: @listing.address
    fill_in "Aif", with: @listing.aif
    check "Aircon" if @listing.aircon
    check "Balcony" if @listing.balcony
    fill_in "Barangay", with: @listing.barangay
    check "Cableprov" if @listing.cableprov
    check "Carport" if @listing.carport
    check "Cctv" if @listing.cctv
    fill_in "Citizenship", with: @listing.citizenship
    check "Cityview" if @listing.cityview
    check "Clubhouse" if @listing.clubhouse
    check "Conveniencestore" if @listing.conveniencestore
    check "Coveredcourt" if @listing.coveredcourt
    check "Crfixtures" if @listing.crfixtures
    fill_in "Description", with: @listing.description
    check "Dirtykitchen" if @listing.dirtykitchen
    check "Drainagesystem" if @listing.drainagesystem
    check "Facingeast" if @listing.facingeast
    check "Filipinocitizen" if @listing.filipinocitizen
    check "Firesystem" if @listing.firesystem
    fill_in "Furnish type", with: @listing.furnish_type
    check "Garden" if @listing.garden
    check "Gate" if @listing.gate
    check "Guardhouse" if @listing.guardhouse
    check "Homecctv" if @listing.homecctv
    check "Homepool" if @listing.homepool
    check "Intercom" if @listing.intercom
    check "Internetprov" if @listing.internetprov
    check "Joggingpaths" if @listing.joggingpaths
    check "Lanai" if @listing.lanai
    check "Landscaping" if @listing.landscaping
    check "Lightfixtures" if @listing.lightfixtures
    fill_in "Listing type", with: @listing.listing_type
    check "Meterperunit" if @listing.meterperunit
    check "Modkitchen" if @listing.modkitchen
    check "Mountainview" if @listing.mountainview
    check "Ownerabroad" if @listing.ownerabroad
    check "Parks" if @listing.parks
    check "Perimeterfence" if @listing.perimeterfence
    check "Petfriendly" if @listing.petfriendly
    check "Playground" if @listing.playground
    check "Pool" if @listing.pool
    fill_in "Price", with: @listing.price
    fill_in "Project type", with: @listing.project_type
    check "Provaircon" if @listing.provaircon
    check "Smarthomeready" if @listing.smarthomeready
    fill_in "Tin", with: @listing.tin
    fill_in "Title", with: @listing.title
    check "Undergroundlines" if @listing.undergroundlines
    check "Wardrobes" if @listing.wardrobes
    check "Washingmachineprov" if @listing.washingmachineprov
    check "Wastemgmt" if @listing.wastemgmt
    check "Waterheaterprov" if @listing.waterheaterprov
    check "Watersystem" if @listing.watersystem
    check "Watertank" if @listing.watertank
    click_on "Create Listing"

    assert_text "Listing was successfully created"
    click_on "Back"
  end

  test "should update Listing" do
    visit listing_url(@listing)
    click_on "Edit this listing", match: :first

    fill_in "Address", with: @listing.address
    fill_in "Aif", with: @listing.aif
    check "Aircon" if @listing.aircon
    check "Balcony" if @listing.balcony
    fill_in "Barangay", with: @listing.barangay
    check "Cableprov" if @listing.cableprov
    check "Carport" if @listing.carport
    check "Cctv" if @listing.cctv
    fill_in "Citizenship", with: @listing.citizenship
    check "Cityview" if @listing.cityview
    check "Clubhouse" if @listing.clubhouse
    check "Conveniencestore" if @listing.conveniencestore
    check "Coveredcourt" if @listing.coveredcourt
    check "Crfixtures" if @listing.crfixtures
    fill_in "Description", with: @listing.description
    check "Dirtykitchen" if @listing.dirtykitchen
    check "Drainagesystem" if @listing.drainagesystem
    check "Facingeast" if @listing.facingeast
    check "Filipinocitizen" if @listing.filipinocitizen
    check "Firesystem" if @listing.firesystem
    fill_in "Furnish type", with: @listing.furnish_type
    check "Garden" if @listing.garden
    check "Gate" if @listing.gate
    check "Guardhouse" if @listing.guardhouse
    check "Homecctv" if @listing.homecctv
    check "Homepool" if @listing.homepool
    check "Intercom" if @listing.intercom
    check "Internetprov" if @listing.internetprov
    check "Joggingpaths" if @listing.joggingpaths
    check "Lanai" if @listing.lanai
    check "Landscaping" if @listing.landscaping
    check "Lightfixtures" if @listing.lightfixtures
    fill_in "Listing type", with: @listing.listing_type
    check "Meterperunit" if @listing.meterperunit
    check "Modkitchen" if @listing.modkitchen
    check "Mountainview" if @listing.mountainview
    check "Ownerabroad" if @listing.ownerabroad
    check "Parks" if @listing.parks
    check "Perimeterfence" if @listing.perimeterfence
    check "Petfriendly" if @listing.petfriendly
    check "Playground" if @listing.playground
    check "Pool" if @listing.pool
    fill_in "Price", with: @listing.price
    fill_in "Project type", with: @listing.project_type
    check "Provaircon" if @listing.provaircon
    check "Smarthomeready" if @listing.smarthomeready
    fill_in "Tin", with: @listing.tin
    fill_in "Title", with: @listing.title
    check "Undergroundlines" if @listing.undergroundlines
    check "Wardrobes" if @listing.wardrobes
    check "Washingmachineprov" if @listing.washingmachineprov
    check "Wastemgmt" if @listing.wastemgmt
    check "Waterheaterprov" if @listing.waterheaterprov
    check "Watersystem" if @listing.watersystem
    check "Watertank" if @listing.watertank
    click_on "Update Listing"

    assert_text "Listing was successfully updated"
    click_on "Back"
  end

  test "should destroy Listing" do
    visit listing_url(@listing)
    click_on "Destroy this listing", match: :first

    assert_text "Listing was successfully destroyed"
  end
end
