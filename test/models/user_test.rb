require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name:"Example User", email:"example@user.com", password:"helloo", password_confirmation:"helloo")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = 'a' * 244 + "@example.com"
    assert_not @user.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses =  %w[us+er@example.com Us.er@Foo.com A_U-3@hiii.co.uk]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[use@ee,com user.com user@user. foo@bar_baz.com asdf@a+po.cp]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be rejected"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
