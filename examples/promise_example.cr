require "../src/async.cr"

# Still in development!

include Async

# Create a promise from a Proc
promise = FiberPromise.new(->(i : Int32) { puts i }, 12)  # You can give arguments after the proc
# Notice that creating a Promise launch immediatly the wrapped Proc

# Await block the execution until the given Proc is finished
await FiberPromise.new(->do
  puts "time for a nap!"
  sleep 2.seconds
  puts "zzz..."
  sleep 2.seconds
  puts "I'm awake! :)"
end)
puts "I'm after await"

# Awaiting an already finished Promise don't have any effect
await promise

promise = FiberPromise.new(->do
  puts "Let's think about a number..."
  sleep 2.seconds
  Random.rand
end)

# Try displaying a promise : you'll get its state!
puts promise  # #<Async::FiberPromise:object_id> PENDING
puts promise.state  # PENDING
# .get will return it's state too until resolved
puts promise.get  # PENDING

# When a promise is resolved, you can access its returned value
promised_value = await promise
puts promised_value # Random number
puts promise.get  # Random number
puts promise.state  # RESOLVED
puts promise  # #<Async::FiberPromise:object_id> RESOLVED