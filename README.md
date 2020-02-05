# c3poa_docker
The docker image can be found at dockerhub: `docker pull danledinh/c3poa`

The docker container runs c3poa (https://github.com/rvolden/C3POa).

## Usage:

### Create detached container
```
docker run \
-v <source_path>:<container_path> \    # set equivalent paths for ease 
-u $(id -u):$(id -g) \   # set user and group for IO permissions
-t \
-d \
c3poa
```
example
```
docker run \
-v /mnt/vol1/user1:/mnt/vol1/user1 \   
-u $(id -u):$(id -g) \
-t \
-d \
c3poa
```

### Script execution
```
docker exec <container_id> python3 <script>.py \
-a flag_a
-b flag_b
```
example
```
docker exec 94f4ed4944bb python3 C3POa.py \
-r /mnt/vol1/user1/data/longreads/c3poa_testdata/output/pre/merged_R2C2_raw_reads.fastq \
-p /mnt/vol1/user1/data/longreads/c3poa_testdata/output/main/tmp \
-m /mnt/vol1/user1/data/longreads/c3poa_testdata/input/NUC.4.4.mat \
-l 1000 \
-d 500 \
-c /mnt/vol1/user1/data/longreads/c3poa_testdata/input/config \
-o /mnt/vol1/user1/data/longreads/c3poa_testdata/output/main/css.fasta
```
