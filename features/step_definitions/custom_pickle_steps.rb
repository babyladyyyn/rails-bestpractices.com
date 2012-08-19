Given %r{^(\w+) "([^"]+)" & "([^"]+)" exist$} do |model, thing_1, thing_2|
  template =
    case model = model.singularize
    when 'user'
      'a user: "%s" exists with login: "%s"'
    else
      %|a #{model}: "%s" exists|
    end
  [thing_1, thing_2].each{|thing| step template % [thing, thing] }
end
