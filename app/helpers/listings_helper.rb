module ListingsHelper

	def amenities_listings(listing)
    amenities = {
      guardhouse: ["Guard House", "ic-guardhouse.png"],
      perimeterfence: ["Perimeter fence", "ic-perimeter-fence.png"],
      cctv: ["CCTV (Main Areas)", "ic-cctv.png"],
      clubhouse: ["Clubhouse", "ic-clubhouse.png"],
      pool: ["Swimming Pool", "ic-swimming-pool.png"],
      coveredcourt: ["Basketball Court", "ic-basketball-court.png"],
      parks: ["Parks & Gardens", "ic-park.png"],
      playground: ["Playground", "ic-playground.png"],
      joggingpaths: ["Jogging Paths", "ic-jogging-path.png"],
      conveniencestore: ["Commercial Area", "ic-commercial-area.png"],
      watersystem: ["Centralized Water System", "ic-water-system.png"],
      drainagesystem: ["Drainage System", "ic-drainage-system.png"],
      undergroundlines: ["Underground Lines", "ic-underground-lines.png"],
      wastemgmt: ["Waste Management System", "ic-waste-mgmt-system.png"],
      garden: ["Private Garden", "ic-private-garden.png"],
      carport: ["Garage", "ic-garage.png"],
      dirtykitchen: ["Dirty Kitchen", "ic-dirty-kitchen.png"],
      gate: ["Gate", "ic-gate.png"],
      watertank: ["Personal Water Tank", "ic-water-tank.png"],
      homecctv: ["Home Security System", "ic-home-security.png"],
      homepool: ["Private pool", "ic-private-pool.png"],
      lanai: ["Lanai", "ic-lanai.png"],
      landscaping: ["Landscaping", "ic-landscaping.png"],
      aircon: ["Aircon", "ic-aircon.png"],
      wardrobes: ["Built-in Cabinets", "ic-cabinets.png"],
      modkitchen: ["Modular Kitchen", "ic-modular-kitchen.png"],
      crfixtures: ["Bathroom Fixtures", "ic-bathroom-fixtures.png"],
      lightfixtures: ["Basic Lighting & Electrical Fixtures", "ic-lighting-fixtures.png"],
      firesystem: ["Smoke Detectors & Fire Sprinklers", "ic-smoke-detector.png"],
      intercom: ["Intercom or Video Phone System", "ic-intercom.png"],
      internetprov: ["Provision for Internet", "ic-internet-provision.png"],
      cableprov: ["Provision for Cable TV", "ic-cable-tv-provision.png"],
      meterperunit: ["Electric & Water Meter per Unit", "ic-electric-meter.png"],
      washingmachineprov: ["Provision for Washing Machine", "ic-washing-machine-provision.png"],
      waterheaterprov: ["Water Heater Provision", "ic-water-heater-provision.png"],
      smarthomeready: ["Smart Home Ready", "ic-smart-home-ready.png"],
      balcony: ["Balcony", "ic-balcony.png"],
      cityview: ["City View", "ic-city-view.png"],
      mountainview: ["Mountain View", "ic-mountain-view.png"],
      petfriendly: ["Pet-Friendly Units", "ic-pet-friendly.png"],
      facingeast: ["Facing East", "ic-facing-east.png"]
    }

	  amenities.select { |key, _| listing.send(key) }.map do |_, (label, icon_path)|
	    image_tag(icon_path, alt: label, size: "20x20") + " " + label
	  end
	end

	def financing_options(listing)
    {
      bank_financing: "Bank Financing",
      inhouse_financing: "In-house Financing",
      pagibig_financing: "PAG-IBIG Financing",

    }.select { |key, _| listing.send(key) }
  end

end
