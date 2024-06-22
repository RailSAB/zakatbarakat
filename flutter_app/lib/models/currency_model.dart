class CurrencyModel {
  final String name;
  final String code;

  CurrencyModel({required this.name, required this.code});


  static Map<String, String> currencies = {
  'UAE Dirham': 'AED',
  'Afghan Afghani': 'AFN',
  'Albanian Lek': 'ALL',
  'Armenian Dram': 'AMD',
  'Netherlands Antillean Guilder': 'ANG',
  'Angolan Kwanza': 'AOA',
  'Argentine Peso': 'ARS',
  'Australian Dollar': 'AUD',
  'Azerbaijan Manat': 'AZN',
  'Bosnia And Herzegovina Convertible Mark': 'BAM',
  'Barbadian Dollar': 'BBD',
  'Bangladeshi Taka': 'BDT',
  'Bulgarian Lev': 'BGN',
  'Bahraini Dinar': 'BHD',
  'Burundi Franc': 'BIF',
  'Bosnia-Herzegovina Convertible Mark': 'BIH',
  'Brunei Dollar': 'BND',
  'Bolivian Boliviano': 'BOB',
  'Brazilian Real': 'BRL',
  'Bahamian Dollar': 'BSD',
  'Bitcoin': 'BTC',
  'Bhutanese Ngultrum': 'BTN',
  'Belarusian Ruble': 'BYN',
  'Belize Dollar': 'BZD',
  'Canadian Dollar': 'CAD',
  'Congolese Franc': 'CDF',
  'Swiss Franc': 'CHF',
  'Chilean Unit Of Account': 'CLF',
  'Chilean Peso': 'CLP',
  'Chinese Yuan Renminbi': 'CNY',
  'Colombian Peso': 'COP',
  'Costa Rican Colon': 'CRC',
  'Cape Verdean Escudo': 'CVE',
  'Czech Koruna': 'CZK',
  'Djiboutian Franc': 'DJF',
  'Danish Krone': 'DKK',
  'Dominican Peso': 'DOP',
  'Algerian Dinar': 'DZD',
  'Egyptian Pound': 'EGP',
  'Eritrean Nakfa': 'ERN',
  'Ethiopian Birr': 'ETB',
  'Ethereum': 'ETH',
  'European Euro': 'EUR',
  'Fijian Dollar': 'FJD',
  'Falkland Islands Pound': 'FKP',
  'Pound Sterling': 'GBP',
  'Georgian Lari': 'GEL',
  'Ghanaian Cedi': 'GHS',
  'Gibraltar Pound': 'GIP',
  'Gambian Dalasi': 'GMD',
  'Guinean Franc': 'GNF',
  'Guatemalan Quetzal': 'GTQ',
  'Guyanese Dollar': 'GYD',
  'Hong Kong Dollar': 'HKD',
  'Honduran Lempira': 'HNL',
  'Croatian Kuna': 'HRK',
  'Haitian Gourde': 'HTG',
  'Hungarian Forint': 'HUF',
  'Indonesian Rupiah': 'IDR',
  'Israeli New Shekel': 'ILS',
  'Indian Rupee': 'INR',
  'Iraqi Dinar': 'IQD',
  'Iranian Rial': 'IRR',
  'Icelandic Krona': 'ISK',
  'Jamaican Dollar': 'JMD',
  'Jordanian Dinar': 'JOD',
  'Japanese Yen': 'JPY',
  'Kenyan Shilling': 'KES',
  'Kyrgyzstani Som': 'KGS',
  'Cambodian Riel': 'KHR',
  'Comorian Franc': 'KMF',
  'South Korean Won': 'KRW',
  'Kuwaiti Dinar': 'KWD',
  'Cayman Islands Dollar': 'KYD',
  'Kazakhstani Tenge': 'KZT',
  'Lao Kip': 'LAK',
  'Lebanese Pound': 'LBP',
  'Sri Lankan Rupee': 'LKR',
  'Liberian Dollar': 'LRD',
  'Lesotho Loti': 'LSL',
  'Libyan Dinar': 'LYD',
  'Moroccan Dirham': 'MAD',
  'Moldovan Leu': 'MDL',
  'Malagasy Ariary': 'MGA',
  'Macedonian Denar': 'MKD',
  'Myanmar Kyat': 'MMK',
  'Mongolian Tugrik': 'MNT',
  'Macanese Pataca': 'MOP',
  'Mauritanian Ouguiya': 'MRO',
  'Mauritian Rupee': 'MUR',
  'Maldivian Rufiyaa': 'MVR',
  'Malawian Kwacha': 'MWK',
  'Mexican Peso': 'MXN',
  'Malaysian Ringgit': 'MYR',
  'Mozambican Metical': 'MZN',
  'Namibian Dollar': 'NAD',
  'Nigerian Naira': 'NGN',
  'Nicaraguan Cordoba': 'NIO',
  'Norwegian Krone': 'NOK',
  'Nepalese Rupee': 'NPR',
  'New Zealand Dollar': 'NZD',
  'Omani Rial': 'OMR',
  'Panamanian Balboa': 'PAB',
  'Peruvian Sol': 'PEN',
  'Philippine Peso': 'PHP',
  'Pakistani Rupee': 'PKR',
  'Polish Zloty': 'PLN',
  'Paraguayan Guarani': 'PYG',
  'Qatari Riyal': 'QAR',
  'Romanian Leu': 'RON',
  'Serbian Dinar': 'RSD',
  'Russian Ruble': 'RUB',
  'Rwandan Franc': 'RWF',
  'Saudi Arabian Riyal': 'SAR',
  'Seychellois Rupee': 'SCR',
  'Sudanese Pound': 'SDG',
  'Swedish Krona': 'SEK',
  'Singapore Dollar': 'SGD',
  'Saint Helena Pound': 'SHP',
  'Sierra Leonean Leone': 'SLL',
  'Somali Shilling': 'SOS',
  'Surinamese Dollar': 'SRD',
  'Sao Tome And Principe Dobra': 'STN',
  'Salvadoran Colón': 'SVC',
  'Swazi Lilangeni': 'SZL',
  'Thai Baht': 'THB',
  'Tajikistani Somoni': 'TJS',
  'Turkmen Manat': 'TMT',
  'Tunisian Dinar': 'TND',
  'Tongan Pa\'anga': 'TOP',
  'Turkish Lira': 'TRY',
  'Trinidad And Tobago Dollar': 'TTD',
  'New Taiwan Dollar': 'TWD',
  'Tanzanian Shilling': 'TZS',
  'Ukrainian Hryvnia': 'UAH',
  'Ugandan Shilling': 'UGX',
  'United States Dollar': 'USD',
  'Uruguayan Peso': 'UYU',
  'Uzbekistani Som': 'UZS',
  'Venezuelan Bolivar': 'VES',
  'Vietnamese Dong': 'VND',
  'Vanuatu Vatu': 'VUV',
  'Samoan Tala': 'WST',
  'Central African CFA Franc': 'XAF',
  'East Caribbean Dollar': 'XCD',
  'West African CFA Franc': 'XOF',
  'CFP Franc': 'XPF',
  'Ripple': 'XRP',
  'Yemeni Rial': 'YER',
  'South African Rand': 'ZAR',
  'Zambian Kwacha (pre-2013)': 'ZMK',
  'Zambian Kwacha': 'ZMW'
};


}