class PlacesSerializer
    include JSONAPI::Serializer
    attributes :id, :name, :state, :city, :street, :number, :photo_url, :description
end