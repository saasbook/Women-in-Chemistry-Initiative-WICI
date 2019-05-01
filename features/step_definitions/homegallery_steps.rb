When /^(?:|I )press the first image$/ do
  find("img[id='0']").click
end

Then /^(?:|I )should see the first image$/ do
  expect(page).to have_xpath("//img[contains(@src,'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/29749500_1846027302356928_1424356246379965960_o.jpg?_nc_cat=105&_nc_ht=scontent-sjc3-1.xx&oh=62035fae7e54f571638975b4794a9020&oe=5D3F1A8C')]")
end

Then /^(?:|I )should see the last image$/ do
  expect(page).to have_xpath("//img[contains(@src,'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/22791912_1781779578781701_2304727614290918746_o.jpg?_nc_cat=110&_nc_ht=scontent-sjc3-1.xx&oh=6a229eb4c1a61a4bc0ef5de48a7e3d00&oe=5D696319')]")
end

Then /^(?:|I )should see the second image$/ do
  expect(page).to have_xpath("//img[contains(@src,'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/22769682_1781777335448592_5772115123594286650_o.jpg?_nc_cat=108&_nc_ht=scontent-sjc3-1.xx&oh=ba15f1f38bd7edc06e0dd97ee7aa3d7e&oe=5D6FDE36')]")
end
