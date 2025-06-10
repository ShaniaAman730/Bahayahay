require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = listings(:one)
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    assert_difference("Listing.count") do
      post listings_url, params: { listing: { address: @listing.address, aif: @listing.aif, aircon: @listing.aircon, balcony: @listing.balcony, barangay: @listing.barangay, cableprov: @listing.cableprov, carport: @listing.carport, cctv: @listing.cctv, citizenship: @listing.citizenship, cityview: @listing.cityview, clubhouse: @listing.clubhouse, conveniencestore: @listing.conveniencestore, coveredcourt: @listing.coveredcourt, crfixtures: @listing.crfixtures, description: @listing.description, dirtykitchen: @listing.dirtykitchen, drainagesystem: @listing.drainagesystem, facingeast: @listing.facingeast, filipinocitizen: @listing.filipinocitizen, firesystem: @listing.firesystem, furnish_type: @listing.furnish_type, garden: @listing.garden, gate: @listing.gate, guardhouse: @listing.guardhouse, homecctv: @listing.homecctv, homepool: @listing.homepool, intercom: @listing.intercom, internetprov: @listing.internetprov, joggingpaths: @listing.joggingpaths, lanai: @listing.lanai, landscaping: @listing.landscaping, lightfixtures: @listing.lightfixtures, listing_type: @listing.listing_type, meterperunit: @listing.meterperunit, modkitchen: @listing.modkitchen, mountainview: @listing.mountainview, ownerabroad: @listing.ownerabroad, parks: @listing.parks, perimeterfence: @listing.perimeterfence, petfriendly: @listing.petfriendly, playground: @listing.playground, pool: @listing.pool, price: @listing.price, project_type: @listing.project_type, provaircon: @listing.provaircon, smarthomeready: @listing.smarthomeready, tin: @listing.tin, title: @listing.title, undergroundlines: @listing.undergroundlines, wardrobes: @listing.wardrobes, washingmachineprov: @listing.washingmachineprov, wastemgmt: @listing.wastemgmt, waterheaterprov: @listing.waterheaterprov, watersystem: @listing.watersystem, watertank: @listing.watertank } }
    end

    assert_redirected_to listing_url(Listing.last)
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    patch listing_url(@listing), params: { listing: { address: @listing.address, aif: @listing.aif, aircon: @listing.aircon, balcony: @listing.balcony, barangay: @listing.barangay, cableprov: @listing.cableprov, carport: @listing.carport, cctv: @listing.cctv, citizenship: @listing.citizenship, cityview: @listing.cityview, clubhouse: @listing.clubhouse, conveniencestore: @listing.conveniencestore, coveredcourt: @listing.coveredcourt, crfixtures: @listing.crfixtures, description: @listing.description, dirtykitchen: @listing.dirtykitchen, drainagesystem: @listing.drainagesystem, facingeast: @listing.facingeast, filipinocitizen: @listing.filipinocitizen, firesystem: @listing.firesystem, furnish_type: @listing.furnish_type, garden: @listing.garden, gate: @listing.gate, guardhouse: @listing.guardhouse, homecctv: @listing.homecctv, homepool: @listing.homepool, intercom: @listing.intercom, internetprov: @listing.internetprov, joggingpaths: @listing.joggingpaths, lanai: @listing.lanai, landscaping: @listing.landscaping, lightfixtures: @listing.lightfixtures, listing_type: @listing.listing_type, meterperunit: @listing.meterperunit, modkitchen: @listing.modkitchen, mountainview: @listing.mountainview, ownerabroad: @listing.ownerabroad, parks: @listing.parks, perimeterfence: @listing.perimeterfence, petfriendly: @listing.petfriendly, playground: @listing.playground, pool: @listing.pool, price: @listing.price, project_type: @listing.project_type, provaircon: @listing.provaircon, smarthomeready: @listing.smarthomeready, tin: @listing.tin, title: @listing.title, undergroundlines: @listing.undergroundlines, wardrobes: @listing.wardrobes, washingmachineprov: @listing.washingmachineprov, wastemgmt: @listing.wastemgmt, waterheaterprov: @listing.waterheaterprov, watersystem: @listing.watersystem, watertank: @listing.watertank } }
    assert_redirected_to listing_url(@listing)
  end

  test "should destroy listing" do
    assert_difference("Listing.count", -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end
end
