# Benchmarking
echo -e "This script measures the speed of your machine in various ways:"
echo -e "Storage space speeds, CPU, and a generalized benchmark."

# Resources:
#  wget -qO- bench.sh | bash
#  iostat -dcx
#  https://haydenjames.io/web-host-doesnt-want-read-benchmark-vps/
#    * https://github.com/haydenjames/bench-scripts
#    * https://github.com/haydenjames/awesome-sysadmin
#  https://www.howtoforge.com/how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench
#  https://www.getpagespeed.com/troubleshooting/test-ssd-ram-vps

echo -e "Make sure you have a few gigabytes of free disk space."
echo -e "Press Enter... "; read shit

echo -e "\n***** Write speed (want >400 MB/s)"
# test the write speed of your storage
# You’ll want this to be above 400 MB/s
# Run this test a couple of times to a find the average
dd if=/dev/zero of=diskbench bs=1M count=1024 conv=fdatasync
dd if=/dev/zero of=diskbench bs=1M count=1024 conv=fdatasync
dd if=/dev/zero of=diskbench bs=1M count=1024 conv=fdatasync
echo -e "Press Enter... "; read shit

# delete the server’s buffer cache in order to measure ‘read’ speeds direct from the hard drive
echo 3 | sudo tee /proc/sys/vm/drop_caches

echo -e "\n***** Read speed"
# Now that cache is deleted, we can test disk read performance of that ‘diskbench’ file
# After running the command once it will be pushed to buffer cache.
# Run it 3 times to average, clearing buffer cache each time to get a raw 1st-read speed
dd if=diskbench of=/dev/null bs=1M count=1024
echo 3 | sudo tee /proc/sys/vm/drop_caches
dd if=diskbench of=/dev/null bs=1M count=1024
echo 3 | sudo tee /proc/sys/vm/drop_caches
dd if=diskbench of=/dev/null bs=1M count=1024
echo -e "Press Enter... "; read shit

echo -e "\n***** Bufferred Read speed"
# Next lets test read speeds using buffer cache by repeating the previous command w/o clearing cache
# Run this test a couple of times to a find the average
dd if=diskbench of=/dev/null bs=1M count=1024
dd if=diskbench of=/dev/null bs=1M count=1024
dd if=diskbench of=/dev/null bs=1M count=1024
echo -e "Press Enter... "; read shit

# Remove the large file
rm diskbench

echo -e "\n***** CPU benchmark (want >300 MB/s)"
# a simple CPU benchmark
# For most modern CPUs, you’ll want to see a minimum of 300 MB/s. 
# Lower than that should prompt you to perform more accurate tests using BYTEmark or even unixbench
dd if=/dev/zero bs=1M count=1024 | md5sum
dd if=/dev/zero bs=1M count=1024 | md5sum
dd if=/dev/zero bs=1M count=1024 | md5sum
echo -e "A lengthy benchmark will run next. It could take a few minutes..."
echo -e "Press Enter... "; read shit

wget -qO- bench.sh | bash
