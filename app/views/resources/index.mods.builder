xml.instruct! :xml, :version=>"1.0" 
xml.modsCollection(
        'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
        'xmlns' => "http://www.loc.gov/mods/v3"){
  @resources.each do |manifestation|
      xml << render(:partial => 'show', :locals => {:manifestation => manifestation})
  end
}