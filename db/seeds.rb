Review.destroy_all
Review.create!(content: "awesome!", camera: Camera.first)
Review.create!(content: "not good at all!", camera: Camera.last)
