FactoryBot.define do

  factory :destination do
    destination_family_name           {"阿部"}
    destination_first_name            {"貞雄"}
    destination_kana_family_name      {"アベ"}
    destination_kana_first_name      {"サダオ"}
    post_code                         {"1111111"}
    prefecture_id                     {"1"}
    municipality                      {"札幌市"}
    house_number                      {"青葉1-1-1"}
    building_name                     {"柳ビル103"}
    phone_number                      {"12345678910"}
  end
end