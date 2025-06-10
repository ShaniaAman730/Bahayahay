class DevProject < ApplicationRecord
	belongs_to :user
	
	has_many_attached :project_photos

	has_rich_text :description

	paginates_per 10

	enum :barangay, { "Abella": 0, "Bagumbayan Norte": 1, "Bagumbaya Sur": 2, "Balatas": 3, "Calauag": 4, "Cararayan": 5, "Carolina": 6, "Concepcion Grande": 7, "Concepcion Pequeña": 8, "Dayangdang": 9, "Del Rosario": 10, "Dinaga": 11, "Igualdad": 12, "Lerma": 13, "Liboton": 13, "Mabolo": 14, "Pacol": 15, "Panicuason": 16, "Peñafrancia": 17, "Sabang": 18, "San Felipe": 19, "San Francisco": 20, "San Isidro": 21, "Santa Cruz": 22, "Tabuco": 23, "Tinago": 24, "Triangulo": 25 }

	enum :property_type, { "Subdivision": 0, "Condominium": 1, "Commercial": 3 }
end



