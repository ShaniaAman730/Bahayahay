class Listing < ApplicationRecord

	belongs_to :realtor, class_name: "User"
 	belongs_to :client, class_name: "User", optional: true
 	belongs_to :developer, class_name: "User", optional: true
 	has_one :review, dependent: :destroy
 	has_one :review_event, dependent: :destroy
 	has_many :saved_listings, dependent: :destroy
	has_many :users_who_saved, through: :saved_listings, source: :user
	has_many :statistics, as: :trackable, dependent: :destroy
	has_many :property_amenities, as: :property, dependent: :destroy
	has_many :amenities, through: :property_amenities

	has_many_attached :listing_photos
	has_one_attached :valid_id
	has_one_attached :birthcert
	has_many_attached :spa
	has_many_attached :tct

	has_rich_text :description
	validate :description_length_within_limit

	validates :listing_photos, total_file_size: { less_than: 2.megabytes }
	validates :valid_id, total_file_size: { less_than: 200.kilobytes }
	validates :birthcert, total_file_size: { less_than: 200.kilobytes }
	validates :spa, total_file_size: { less_than: 500.kilobytes }
	validates :tct, total_file_size: { less_than: 1000.kilobytes }

	validate :listing_photos_limit
	validate :validate_spa_attachment_limit
  validate :validate_tct_attachment_limit

  validate :realtor_must_have_realty, on: :create

  validates :title, presence: true
  validates :beds, :baths, :sqft, numericality: { only_integer: true, allow_nil: true }
  validates :price, numericality: { allow_nil: true }
  validates :address, presence: true
  validates :owneralive, :filipinocitizen, :ownerabroad,
  					 inclusion: { in: [true, false], message: "must be selected" },
  					 if: -> { listing_type_num == 1 }

	paginates_per 10

	enum :furnish_type, { "Fully furnished": 1, "Semi-furnished": 2, "Bare unit": 3, "Not Applicable": 4 }
	enum :barangay, { 'Abella': 0, 'Bagumbayan Norte': 1, 'Bagumbayan Sur': 2, 'Balatas': 3, 'Calauag': 4, 'Cararayan': 5, 'Carolina': 6, 'Concepcion Grande': 7, 'Concepcion Pequeña': 8, 'Dayangdang': 9, 'Del Rosario': 10, 'Dinaga': 11, 'Igualdad': 12, 'Lerma': 13, 'Liboton': 13, 'Mabolo': 14, 'Pacol': 15, 'Panicuason': 16, 'Peñafrancia': 17, 'Sabang': 18, 'San Felipe': 19, 'San Francisco': 20, 'San Isidro': 21, 'Santa Cruz': 22, 'Tabuco': 23, 'Tinago': 24, 'Triangulo': 25 }
	enum :project_type, { 'Subdivision': 0, 'Condominium': 1, 'Commercial': 3, 'Build-and-Sell': 4, 'Pre-owned': 5, 'Lot only': 6 }
	enum :listing_type, { project: 0, independent: 1 }
	enum :citizenship, {
						  "Afghan": 0, "Albanian": 1, "Algerian": 2, "American": 3, "Andorran": 4, "Angolan": 5, "Anguillan": 6,
						  "Citizen of Antigua and Barbuda": 7, "Argentine": 8, "Armenian": 9, "Australian": 10, "Austrian": 11,
						  "Azerbaijani": 12, "Bahamian": 13, "Bahraini": 14, "Bangladeshi": 15, "Barbadian": 16, "Belarusian": 17,
						  "Belgian": 18, "Belizean": 19, "Beninese": 20, "Bermudian": 21, "Bhutanese": 22, "Bolivian": 23,
						  "Citizen of Bosnia and Herzegovina": 24, "Botswanan": 25, "Brazilian": 26, "British": 27,
						  "British Virgin Islander": 28, "Bruneian": 29, "Bulgarian": 30, "Burkinan": 31, "Burmese": 32,
						  "Burundian": 33, "Cambodian": 34, "Cameroonian": 35, "Canadian": 36, "Cape Verdean": 37,
						  "Cayman Islander": 38, "Central African": 39, "Chadian": 40, "Chilean": 41, "Chinese": 42,
						  "Colombian": 43, "Comoran": 44, "Congolese (Congo)": 45, "Congolese (DRC)": 46, "Cook Islander": 47,
						  "Costa Rican": 48, "Croatian": 49, "Cuban": 50, "Cymraes": 51, "Cymro": 52, "Cypriot": 53, "Czech": 54,
						  "East Timorese": 55, "Ecuadorean": 56, "Egyptian": 57, "Emirati": 58, "English": 59,
						  "Equatorial Guinean": 60, "Eritrean": 61, "Estonian": 62, "Ethiopian": 63, "Faroese": 64,
						  "Fijian": 65, "Filipino": 66, "Finnish": 67, "French": 68, "Gabonese": 69, "Gambian": 70,
						  "Georgian": 71, "German": 72, "Ghanaian": 73, "Gibraltarian": 74, "Greek": 75, "Greenlandic": 76,
						  "Grenadian": 77, "Guamanian": 78, "Guatemalan": 79, "Citizen of Guinea-Bissau": 80, "Guinean": 81,
						  "Guyanese": 82, "Haitian": 83, "Honduran": 84, "Hong Konger": 85, "Hungarian": 86, "Icelandic": 87,
						  "Indian": 88, "Indonesian": 89, "Iranian": 90, "Iraqi": 91, "Irish": 92, "Israeli": 93, "Italian": 94,
						  "Ivorian": 95, "Jamaican": 96, "Japanese": 97, "Jordanian": 98, "Kazakh": 99, "Kenyan": 100,
						  "Kittitian": 101, "Citizen of Kiribati": 102, "Kosovan": 103, "Kuwaiti": 104, "Kyrgyz": 105,
						  "Lao": 106, "Latvian": 107, "Lebanese": 108, "Liberian": 109, "Libyan": 110, "Liechtenstein citizen": 111,
						  "Lithuanian": 112, "Luxembourger": 113, "Macanese": 114, "Macedonian": 115, "Malagasy": 116,
						  "Malawian": 117, "Malaysian": 118, "Maldivian": 119, "Malian": 120, "Maltese": 121, "Marshallese": 122,
						  "Martiniquais": 123, "Mauritanian": 124, "Mauritian": 125, "Mexican": 126, "Micronesian": 127,
						  "Moldovan": 128, "Monegasque": 129, "Mongolian": 130, "Montenegrin": 131, "Montserratian": 132,
						  "Moroccan": 133, "Mosotho": 134, "Mozambican": 135, "Namibian": 136, "Nauruan": 137, "Nepalese": 138,
						  "New Zealander": 139, "Nicaraguan": 140, "Nigerian": 141, "Nigerien": 142, "Niuean": 143,
						  "North Korean": 144, "Northern Irish": 145, "Norwegian": 146, "Omani": 147, "Pakistani": 148,
						  "Palauan": 149, "Palestinian": 150, "Panamanian": 151, "Papua New Guinean": 152, "Paraguayan": 153,
						  "Peruvian": 154, "Pitcairn Islander": 155, "Polish": 156, "Portuguese": 157, "Prydeinig": 158,
						  "Puerto Rican": 159, "Qatari": 160, "Romanian": 161, "Russian": 162, "Rwandan": 163, "Salvadorean": 164,
						  "Sammarinese": 165, "Samoan": 166, "Sao Tomean": 167, "Saudi Arabian": 168, "Scottish": 169,
						  "Senegalese": 170, "Serbian": 171, "Citizen of Seychelles": 172, "Sierra Leonean": 173,
						  "Singaporean": 174, "Slovak": 175, "Slovenian": 176, "Solomon Islander": 177, "Somali": 178,
						  "South African": 179, "South Korean": 180, "South Sudanese": 181, "Spanish": 182, "Sri Lankan": 183,
						  "St Helenian": 184, "St Lucian": 185, "Stateless Sudanese": 186, "Surinamese": 187, "Swazi": 188,
						  "Swedish": 189, "Swiss": 190, "Syrian": 191, "Taiwanese": 192, "Tajik": 193, "Tanzanian": 194,
						  "Thai": 195, "Togolese": 196, "Tongan": 197, "Trinidadian": 198, "Tristanian": 199, "Tunisian": 200,
						  "Turkish": 201, "Turkmen": 202, "Turks and Caicos Islander": 203, "Tuvaluan": 204, "Ugandan": 205,
						  "Ukrainian": 206, "Uruguayan": 207, "Uzbek": 208, "Vatican citizen": 209, "Citizen of Vanuatu": 210,
						  "Venezuelan": 211, "Vietnamese": 212, "Vincentian": 213, "Wallisian": 214, "Welsh": 215, "Yemeni": 216,
						  "Zambian": 217, "Zimbabwean": 218
						}
	scope :independent, -> { where(listing_type_num: 1) }
  	scope :pending_approval, -> { independent.where(approved: false) }
  	scope :approved_listings, -> { where(approved: true) }
  	scope :public_listings, -> {
	  where(active: true).where("(listing_type_num = ? AND approved = ?) OR listing_type_num = ?", 1, true, 0)
	}

	def confirmed_transaction?
	  confirmed && client.present?
	end

	def listing_photos_limit
	  if listing_photos.attached? && listing_photos.count > 14
	    errors.add(:listing_photos, "You can only upload up to 8 files.")
	  end
	end


  def validate_spa_attachment_limit
    if spa.attachments.size > 2
      errors.add(:spa, "can have at most 2 files.")
    end
  end

  def validate_tct_attachment_limit
    if tct.attachments.size > 4
      errors.add(:tct, "can have at most 4 files.")
    end
  end

  def days_since_posted
	  (Date.today - created_at.to_date).to_i
	end

	after_initialize :set_defaults, unless: :persisted?

	def set_defaults
	  self.contact_clicks ||= 0
	end

	def public_listing?
	  active? && (
	    (listing_type_num == 1 && approved?) ||
	    listing_type_num == 0
	  )
	end
	
	def first_photo_url
	  listing_photos.attached? ? Rails.application.routes.url_helpers.rails_blob_url(listing_photos.first, only_path: true) : "/images/default-property.png"
	end


	def realtor_must_have_realty
	  if realtor&.realtor? && !realtor.is_broker && realtor.realty.blank?
	    errors.add(:base, "You must be part of a Realty to post listings. Please submit a Realty application.")
	  end
	end

	def total_views
    statistics.view.count
  end

  def unique_visitors
    statistics.view.distinct.count(:visitor_id)
  end

  def days_since_posted
    (Date.current - created_at.to_date).to_i
  end


	BARANGAY_COORDS = {
    "Abella" => [13.6258, 123.1856],
    "Bagumbayan Norte" => [13.6282, 123.1859],
    "Bagumbayan Sur" => [13.6265, 123.1862],
    "Balatas" => [13.6195, 123.1782],
    "Calauag" => [13.6152, 123.1901],
    "Cararayan" => [13.6093, 123.1845],
    "Carolina" => [13.5975, 123.2100],
    "Concepcion Grande" => [13.6268, 123.1967],
    "Concepcion Pequeña" => [13.6210, 123.2015],
    "Dayangdang" => [13.6242, 123.1894],
    "Del Rosario" => [13.6351, 123.1920],
    "Dinaga" => [13.6203, 123.1928],
    "Igualdad" => [13.6179, 123.1883],
    "Lerma" => [13.6220, 123.1942],
    "Liboton" => [13.6247, 123.1982],
    "Mabolo" => [13.6279, 123.2007],
    "Pacol" => [13.6044, 123.2082],
    "Panicuason" => [13.5770, 123.2321],
    "Peñafrancia" => [13.6198, 123.1965],
    "Sabang" => [13.6206, 123.1850],
    "San Felipe" => [13.6280, 123.2041],
    "San Francisco" => [13.6215, 123.1910],
    "San Isidro" => [13.6062, 123.1943],
    "Santa Cruz" => [13.6187, 123.1878],
    "Tabuco" => [13.6230, 123.1978],
    "Tinago" => [13.6252, 123.1935],
    "Triangulo" => [13.6199, 123.1939]
  }.freeze

  def description_length_within_limit
    max_chars = 1500
    if description.to_plain_text.length > max_chars
      errors.add(:description, "must be #{max_chars} characters or fewer")
    end
  end

end
