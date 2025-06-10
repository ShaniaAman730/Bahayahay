module DevProjectsHelper

	def amenities_dev_projects(dev_project)
    amenities = {
      guardhouse: ["Guard House", "ic-guardhouse.png"],
      perimeterfence: ["Perimeter fence", "ic-perimeter-fence.png"],
      clubhouse: ["Clubhouse", "ic-clubhouse.png"],
      pool: ["Swimming Pool", "ic-swimming-pool.png"],
      coveredcourt: ["Basketball Court", "ic-basketball-court.png"],
      playground: ["Playground", "ic-playground.png"],
      joggingpath: ["Jogging Paths", "ic-jogging-path.png"],
      mphall: ["Multi-purpose Hall", "ic-mphall.png"], # HERE
      tenniscourt: ["Tennis Court", "ic-tenniscourt.png"], # HERE
      retailstrip: ["Retail Strip", "ic-commercial-area.png"], # HERE
      chapel: ["Chapel", "ic-chapel.png"], # HERE
      petpark: ["Pet Parks", "ic-petpark.png"], # HERE
      sewagefacility: ["Sewage Treatment Facility", "ic-sewagefacility.png"], # HERE
      lobbyconcierge: ["Lobby with Reception", "ic-lobbyconcierge.png"], # HERE
      cctv: ["CCTV (Main Areas)", "ic-cctv.png"],
      elevators: ["Elevators", "ic-elevators.png"], # HERE
      gym: ["Gym", "ic-gym.png"], # HERE
      eventhall: ["Event Hall", "ic-eventhall.png"], # HERE
      playarea: ["Children’s Play Area", "ic-playground.png"], # HERE
      roofdeck: ["Roof deck", "ic-roofdeck.png"], # HERE
      parking: ["Parking Area", "ic-parking.png"], # HERE
      firealarm: ["Fire Alarm", "ic-smoke-detector.png"], # HERE
      businesscenter: ["Business Center", "ic-businesscenter.png"], # HERE
      loungearea: ["Lounge area", "ic-loungearea.png"], # HERE
      spa: ["Spa", "ic-spa.png"], # HERE
      laundrystation: ["Laundry station", "ic-laundrystation.png"], # HERE
      generator: ["Backup Generator", "ic-generator.png"], # HERE
      fiberready: ["Internet Ready", "ic-internet-provision.png"], # HERE
      parcellockers: ["Parcel Lockers", "ic-parcellockers.png"], # HERE
      restaurant: ["Café or Restaurant", "ic-restaurant.png"], # HERE
      mall: ["Malls/Supermarkets", "ic-mall.png"], # HERE
      transportterminal: ["Transport Terminals", "ic-transportterminal.png"], # HERE
      bikingtrail: ["Biking trails", "ic-bikingtrail.png"], # HERE
      itpark: ["Business District or IT Park", "ic-itpark.png"], # HERE
      clinic: ["Hospital or Clinic", "ic-clinic.png"] # HERE
    }

	  amenities.select { |key, _| dev_project.send(key) }.map do |_, (label, icon_path)|
	    image_tag(icon_path, alt: label, size: "20x20") + " " + label
	  end
	end

end
