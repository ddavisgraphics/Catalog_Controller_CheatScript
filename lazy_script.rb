collection_solr_names = "identifier,title,creator,personal_names,topic,genre,corporate_names,subject,description,publisher,contributors,date,type,format,source,language,rights,relation,coverage"
collection_solr_names = collection_solr_names.split ','

search_field_string = "
  config.add_search_field('%%fieldname%%') do |field|
    identifier_field = Solrizer.solr_name('%%fieldname%%', :stored_searchable)
    field.solr_local_parameters = {
      qf: %%fieldname%%_field,
      pf: %%fieldname%%_field
    }
  end
"
# for the index fields 
puts "# ------------------------------------------------"
puts "#  Index fields "
puts "# ------------------------------------------------"
collection_solr_names.each do |name| 
  puts "config.add_index_field solr_name('#{name}', :stored_searchable, type: :string), :label => '#{name.capitalize}'"
end 
puts "# ------------------------------------------------"
puts "#  Show fields "
puts "# ------------------------------------------------"
# for all show fields 
collection_solr_names.each do |name| 
  puts "config.add_show_field solr_name('#{name}', :stored_searchable, type: :string), :label => '#{name.capitalize}'"
end 
puts "# ------------------------------------------------"
puts "#  Search Fields "
puts "# ------------------------------------------------"
# for the search fields 
collection_solr_names.each do |name| 
  replaced_content = search_field_string.gsub('%%fieldname%%', name)
  puts replaced_content
end 

puts "" 
