#include <cuda_runtime.h>
#include <stdio.h>

__global__ void scaleTensorWeights(float *matrix, float scale, int size) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < size) {
        matrix[idx] *= scale;
    }
}

extern "C" void launchWeightScaler(float *d_matrix, float scale, int size) {
    int threadsPerBlock = 256;
    int blocksPerGrid = (size + threadsPerBlock - 1) / threadsPerBlock;

    scaleTensorWeights<<<blocksPerGrid, threadsPerBlock>>>(d_matrix, scale, size);
    cudaDeviceSynchronize();
}
