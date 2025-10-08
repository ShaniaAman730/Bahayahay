# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

AMENITIES = [
  # ... dev_project ...
  { name: "guardhouse", label: "Guard House", icon: "ic-guardhouse.png", category: :project },
  { name: "perimeterfence", label: "Perimeter fence", icon: "ic-perimeter-fence.png", category: :project },
  { name: "clubhouse", label: "Clubhouse", icon: "ic-clubhouse.png", category: :project },
  { name: "pool", label: "Swimming Pool", icon: "ic-swimming-pool.png", category: :project },
  { name: "coveredcourt", label: "Basketball Court", icon: "ic-basketball-court.png", category: :project },
  { name: "playground", label: "Playground", icon: "ic-playground.png", category: :project },
  { name: "joggingpath", label: "Jogging Paths", icon: "ic-jogging-path.png", category: :project },
  { name: "mphall", label: "Multi-purpose Hall", icon: "ic-mphall.png", category: :project },
  { name: "tenniscourt", label: "Tennis Court", icon: "ic-tenniscourt.png", category: :project },
  { name: "retailstrip", label: "Retail Strip", icon: "ic-commercial-area.png", category: :project },
  { name: "chapel", label: "Chapel", icon: "ic-chapel.png", category: :project },
  { name: "petpark", label: "Pet Parks", icon: "ic-petpark.png", category: :project },
  { name: "sewagefacility", label: "Sewage Treatment Facility", icon: "ic-sewagefacility.png", category: :project },
  { name: "lobbyconcierge", label: "Lobby with Reception", icon: "ic-lobbyconcierge.png", category: :project },
  { name: "cctv", label: "CCTV (Main Areas)", icon: "ic-cctv.png", category: :project },
  { name: "elevators", label: "Elevators", icon: "ic-elevators.png", category: :project },
  { name: "gym", label: "Gym", icon: "ic-gym.png", category: :project },
  { name: "eventhall", label: "Event Hall", icon: "ic-eventhall.png", category: :project },
  { name: "playarea", label: "Children’s Play Area", icon: "ic-playground.png", category: :project },
  { name: "roofdeck", label: "Roof deck", icon: "ic-roofdeck.png", category: :project },
  { name: "parking", label: "Parking Area", icon: "ic-parking.png", category: :project },
  { name: "firealarm", label: "Fire Alarm", icon: "ic-smoke-detector.png", category: :project },
  { name: "businesscenter", label: "Business Center", icon: "ic-businesscenter.png", category: :project },
  { name: "loungearea", label: "Lounge area", icon: "ic-loungearea.png", category: :project },
  { name: "spa", label: "Spa", icon: "ic-spa.png", category: :project },
  { name: "laundrystation", label: "Laundry station", icon: "ic-laundrystation.png", category: :project },
  { name: "generator", label: "Backup Generator", icon: "ic-generator.png", category: :project },
  { name: "fiberready", label: "Internet Ready", icon: "ic-internet-provision.png", category: :project },
  { name: "parcellockers", label: "Parcel Lockers", icon: "ic-parcellockers.png", category: :project },
  { name: "restaurant", label: "Café or Restaurant", icon: "ic-restaurant.png", category: :project },
  { name: "mall", label: "Malls/Supermarkets", icon: "ic-mall.png", category: :project },
  { name: "transportterminal", label: "Transport Terminals", icon: "ic-transportterminal.png", category: :project },
  { name: "bikingtrail", label: "Biking trails", icon: "ic-bikingtrail.png", category: :project },
  { name: "itpark", label: "Business District or IT Park", icon: "ic-itpark.png", category: :project },
  { name: "clinic", label: "Hospital or Clinic", icon: "ic-clinic.png", category: :project },
  # ... model_house and listing ...
  { name: "guardhouse", label: "Guard House", icon: "ic-guardhouse.png", category: :unit },
  { name: "perimeterfence", label: "Perimeter fence", icon: "ic-perimeter-fence.png", category: :unit },
  { name: "cctv", label: "CCTV (Main Areas)", icon: "ic-cctv.png", category: :unit },
  { name: "clubhouse", label: "Clubhouse", icon: "ic-clubhouse.png", category: :unit },
  { name: "pool", label: "Swimming Pool", icon: "ic-swimming-pool.png", category: :unit },
  { name: "coveredcourt", label: "Basketball Court", icon: "ic-basketball-court.png", category: :unit },
  { name: "parks", label: "Parks & Gardens", icon: "ic-park.png", category: :unit },
  { name: "playground", label: "Playground", icon: "ic-playground.png", category: :unit },
  { name: "joggingpaths", label: "Jogging Paths", icon: "ic-jogging-path.png", category: :unit },
  { name: "conveniencestore", label: "Commercial Area", icon: "ic-commercial-area.png", category: :unit },
  { name: "watersystem", label: "Centralized Water System", icon: "ic-water-system.png", category: :unit },
  { name: "drainagesystem", label: "Drainage System", icon: "ic-drainage-system.png", category: :unit },
  { name: "undergroundlines", label: "Underground Lines", icon: "ic-underground-lines.png", category: :unit },
  { name: "wastemgmt", label: "Waste Management System", icon: "ic-waste-mgmt-system.png", category: :unit },
  { name: "garden", label: "Private Garden", icon: "ic-private-garden.png", category: :unit },
  { name: "carport", label: "Garage", icon: "ic-garage.png", category: :unit },
  { name: "dirtykitchen", label: "Dirty Kitchen", icon: "ic-dirty-kitchen.png", category: :unit },
  { name: "gate", label: "Gate", icon: "ic-gate.png", category: :unit },
  { name: "watertank", label: "Personal Water Tank", icon: "ic-water-tank.png", category: :unit },
  { name: "homecctv", label: "Home Security System", icon: "ic-home-security.png", category: :unit },
  { name: "homepool", label: "Private pool", icon: "ic-private-pool.png", category: :unit },
  { name: "lanai", label: "Lanai", icon: "ic-lanai.png", category: :unit },
  { name: "landscaping", label: "Landscaping", icon: "ic-landscaping.png", category: :unit },
  { name: "aircon", label: "Aircon", icon: "ic-aircon.png", category: :unit },
  { name: "wardrobes", label: "Built-in Cabinets", icon: "ic-cabinets.png", category: :unit },
  { name: "modkitchen", label: "Modular Kitchen", icon: "ic-modular-kitchen.png", category: :unit },
  { name: "crfixtures", label: "Bathroom Fixtures", icon: "ic-bathroom-fixtures.png", category: :unit },
  { name: "lightfixtures", label: "Basic Lighting & Electrical Fixtures", icon: "ic-lighting-fixtures.png", category: :unit },
  { name: "firesystem", label: "Smoke Detectors & Fire Sprinklers", icon: "ic-smoke-detector.png", category: :unit },
  { name: "intercom", label: "Intercom or Video Phone System", icon: "ic-intercom.png", category: :unit },
  { name: "internetprov", label: "Provision for Internet", icon: "ic-internet-provision.png", category: :unit },
  { name: "cableprov", label: "Provision for Cable TV", icon: "ic-cable-tv-provision.png", category: :unit },
  { name: "meterperunit", label: "Electric & Water Meter per Unit", icon: "ic-electric-meter.png", category: :unit },
  { name: "washingmachineprov", label: "Provision for Washing Machine", icon: "ic-washing-machine-provision.png", category: :unit },
  { name: "waterheaterprov", label: "Water Heater Provision", icon: "ic-water-heater-provision.png", category: :unit },
  { name: "smarthomeready", label: "Smart Home Ready", icon: "ic-smart-home-ready.png", category: :unit },
  { name: "balcony", label: "Balcony", icon: "ic-balcony.png", category: :unit },
  { name: "cityview", label: "City View", icon: "ic-city-view.png", category: :unit },
  { name: "mountainview", label: "Mountain View", icon: "ic-mountain-view.png", category: :unit },
  { name: "petfriendly", label: "Pet-Friendly Units", icon: "ic-pet-friendly.png", category: :unit },
  { name: "facingeast", label: "Facing East", icon: "ic-facing-east.png", category: :unit }
]

AMENITIES.each do |attrs|
  Amenity.find_or_create_by!(name: attrs[:name], category: attrs[:category]) do |a|
  a.label = attrs[:label]
  a.icon  = attrs[:icon]
  end
end


