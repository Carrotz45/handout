def get(resource, &block)
    block.call()
    block.call()
    block.call()
    
end


get("/pictures/:id") do
    print("hello")
end

