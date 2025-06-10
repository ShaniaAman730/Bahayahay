require "test_helper"

class ModelHousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model_house = model_houses(:one)
  end

  test "should get index" do
    get model_houses_url
    assert_response :success
  end

  test "should get new" do
    get new_model_house_url
    assert_response :success
  end

  test "should create model_house" do
    assert_difference("ModelHouse.count") do
      post model_houses_url, params: { model_house: { aircon: @model_house.aircon, balcony: @model_house.balcony, cableprov: @model_house.cableprov, carport: @model_house.carport, cctv: @model_house.cctv, cityview: @model_house.cityview, clubhouse: @model_house.clubhouse, conveniencestore: @model_house.conveniencestore, coveredcourt: @model_house.coveredcourt, crfixtures: @model_house.crfixtures, description: @model_house.description, dirtykitchen: @model_house.dirtykitchen, drainagesystem: @model_house.drainagesystem, facingeast: @model_house.facingeast, firesystem: @model_house.firesystem, furnish_type: @model_house.furnish_type, garden: @model_house.garden, gate: @model_house.gate, guardhouse: @model_house.guardhouse, homecctv: @model_house.homecctv, homepool: @model_house.homepool, inherit_amenities: @model_house.inherit_amenities, intercom: @model_house.intercom, internetprov: @model_house.internetprov, joggingpaths: @model_house.joggingpaths, lanai: @model_house.lanai, landscaping: @model_house.landscaping, lightfixtures: @model_house.lightfixtures, meterperunit: @model_house.meterperunit, modkitchen: @model_house.modkitchen, mountainview: @model_house.mountainview, parks: @model_house.parks, perimeterfence: @model_house.perimeterfence, petfriendly: @model_house.petfriendly, playground: @model_house.playground, pool: @model_house.pool, price: @model_house.price, provaircon: @model_house.provaircon, smarthomeready: @model_house.smarthomeready, title: @model_house.title, undergroundlines: @model_house.undergroundlines, wardrobes: @model_house.wardrobes, washingmachineprov: @model_house.washingmachineprov, wastemgmt: @model_house.wastemgmt, waterheaterprov: @model_house.waterheaterprov, watersystem: @model_house.watersystem, watertank: @model_house.watertank } }
    end

    assert_redirected_to model_house_url(ModelHouse.last)
  end

  test "should show model_house" do
    get model_house_url(@model_house)
    assert_response :success
  end

  test "should get edit" do
    get edit_model_house_url(@model_house)
    assert_response :success
  end

  test "should update model_house" do
    patch model_house_url(@model_house), params: { model_house: { aircon: @model_house.aircon, balcony: @model_house.balcony, cableprov: @model_house.cableprov, carport: @model_house.carport, cctv: @model_house.cctv, cityview: @model_house.cityview, clubhouse: @model_house.clubhouse, conveniencestore: @model_house.conveniencestore, coveredcourt: @model_house.coveredcourt, crfixtures: @model_house.crfixtures, description: @model_house.description, dirtykitchen: @model_house.dirtykitchen, drainagesystem: @model_house.drainagesystem, facingeast: @model_house.facingeast, firesystem: @model_house.firesystem, furnish_type: @model_house.furnish_type, garden: @model_house.garden, gate: @model_house.gate, guardhouse: @model_house.guardhouse, homecctv: @model_house.homecctv, homepool: @model_house.homepool, inherit_amenities: @model_house.inherit_amenities, intercom: @model_house.intercom, internetprov: @model_house.internetprov, joggingpaths: @model_house.joggingpaths, lanai: @model_house.lanai, landscaping: @model_house.landscaping, lightfixtures: @model_house.lightfixtures, meterperunit: @model_house.meterperunit, modkitchen: @model_house.modkitchen, mountainview: @model_house.mountainview, parks: @model_house.parks, perimeterfence: @model_house.perimeterfence, petfriendly: @model_house.petfriendly, playground: @model_house.playground, pool: @model_house.pool, price: @model_house.price, provaircon: @model_house.provaircon, smarthomeready: @model_house.smarthomeready, title: @model_house.title, undergroundlines: @model_house.undergroundlines, wardrobes: @model_house.wardrobes, washingmachineprov: @model_house.washingmachineprov, wastemgmt: @model_house.wastemgmt, waterheaterprov: @model_house.waterheaterprov, watersystem: @model_house.watersystem, watertank: @model_house.watertank } }
    assert_redirected_to model_house_url(@model_house)
  end

  test "should destroy model_house" do
    assert_difference("ModelHouse.count", -1) do
      delete model_house_url(@model_house)
    end

    assert_redirected_to model_houses_url
  end
end
