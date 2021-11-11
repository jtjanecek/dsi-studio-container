# About
This is a Dockerfile for DSI-Studio. It specifically uses the July 6th version of DSI-Studio, but it also includes the latest atlas.

## Docker
### Build
```
docker build -t dsi_studio .
```
### Run
```
docker run -v $PWD:/data dsi_studio [args]
```
## Singularity
### Build
```
sudo singularity build dsi_studio.simg DSI-Studio.def
```
### Run
```
singularity run --bind $PWD:/data dsi_studio.simg [args]
```
