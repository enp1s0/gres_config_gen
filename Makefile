CXX=nvcc
CXXFLAGS=-std=c++11
TARGET=gres_conf_gen

$(TARGET):main.cu
	$(CXX) $< $(CXXFLAGS) -o $@

clean:
	rm -f $(TARGET)
