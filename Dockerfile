FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

RUN apt-get update && \
    apt-get install -y curl cmake git g++ pkg-config protobuf-compiler libprotobuf-dev libzstd-dev python3
RUN curl -sL https://developer.download.nvidia.com/compute/nvcomp/2.6.1/local_installers/nvcomp_2.6.1_x86_64_12.x.tgz | tar xzvf - --directory=/usr/local

RUN git clone https://github.com/CODARcode/MGARD.git
RUN mkdir MGARD/build && \
    cd MGARD/build && \
    cmake -DMGARD_ENABLE_OPENMP=ON -DMGARD_ENABLE_CUDA=ON -DMGARD_ENABLE_MDR=ON -DCMAKE_CUDA_ARCHITECTURES="80;86" .. && \
    make -j $(nproc) && \
    make install && \
    ldconfig
