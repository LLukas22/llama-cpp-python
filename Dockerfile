FROM python:3.10

# Install dependencies

#Copy the compiled llama.so file to the container
COPY ./lib /lib/

#Set the environment variable for the llama.so file
ENV LLAMA_CPP_LIB /lib/llama.so

# Copy the python code to the container
RUN mkdir -p /app
COPY ./llama_cpp /app
WORKDIR /app

#Add the current directory to the PYTHONPATH
ENV PYTHONPATH "${PYTHONPATH}:/app"

# Install Requirements
RUN --mount=type=cache,target=/root/.cache/pip pip3 install -r ./server/requirements.txt

#Set default environment variables
ENV HOST 0.0.0.0
ENV PORT 8000

#Expose the port
EXPOSE ${PORT}

#Run the server
CMD ["python3","-m","server"]


