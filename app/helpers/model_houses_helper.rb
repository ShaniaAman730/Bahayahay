module ModelHousesHelper
	def financing_options(model_house)
    {
      bank_financing: "Bank Financing",
      inhouse_financing: "In-house Financing",
      pagibig_financing: "PAG-IBIG Financing",

    }.select { |key, _| model_house.send(key) }
  end

end
