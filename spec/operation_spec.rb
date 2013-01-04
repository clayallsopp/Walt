describe "Walt::Operation" do
  it "should return proper subclass for :type" do
    o = Walt::Operation.for({type: :move})
    o.is_a?(Walt::Operation::MoveOperation).should == true

    o = Walt::Operation.for({type: :fade})
    o.is_a?(Walt::Operation::FadeOperation).should == true

    Walt::Operation.operation_types.each do |op|
      string = "#{op.to_s.downcase}_operation".camelize
      klass = Walt::Operation.const_get(string)

      o = Walt::Operation.for({op => :blue})
      o.is_a?(klass).should == true
      o.id.should == :blue
    end
  end

  it "should have nested attributes" do
    o = Walt::Operation.for(type: :move, id: :herp, from: 0, to: 10)
    o.type.should == :move
    o.id.should == :herp
    o.from.should.not == nil
    o.to.should.not == nil
  end
end