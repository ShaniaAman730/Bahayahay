module ListingsHelper
	def financing_options(listing)
    {
      bank_financing: "Bank Financing",
      inhouse_financing: "In-house Financing",
      pagibig_financing: "PAG-IBIG Financing",

    }.select { |key, _| listing.send(key) }
  end
end
