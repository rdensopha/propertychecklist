node do |m|
 { item: @result_hash.values.collect {|val| val.to_s },
   settings: {
      axisx: @result_hash.keys,
      axisy: %w{Min Max},
      colour: "ff9900"
   }
 }      
end