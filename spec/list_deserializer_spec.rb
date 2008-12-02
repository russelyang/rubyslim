require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require "list_serializer"
require "list_deserializer"

describe ListDeserializer do
  before do
    @list = []
  end

  it "can't deserialize a null string" do
    proc {ListDeserializer.deserialize(nil)}.should raise_error(ListDeserializer::SyntaxError)
  end

  it "can't deserialize empty string" do
    proc {ListDeserializer.deserialize("")}.should raise_error(ListDeserializer::SyntaxError)
  end

  it "can't deserialize string that doesn't start with an open bracket" do
    proc {ListDeserializer.deserialize("hello")}.should raise_error(ListDeserializer::SyntaxError)
  end

  it "can't deserialize string that doesn't end with a bracket" do
    proc {ListDeserializer.deserialize("[000000:")}.should raise_error(ListDeserializer::SyntaxError)    
  end

  def check()
    serialized = ListSerializer.serialize(@list)
    deserialized = ListDeserializer.deserialize(serialized)
    deserialized.should == @list
  end

  it "should deserialize and empty list" do
    check
  end

  it "should deserialize a list with one element" do
    @list = ["hello"]
    check
  end

  it "should deserialize a list with two elements" do
    @list = ["hello", "bob"]
    check
  end

  it "should deserialize sublists" do
    @list = ["hello", ["bob", "micah"], "today"]
    check
  end


end