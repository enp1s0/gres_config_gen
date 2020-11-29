#include <iostream>
#include <fstream>
#include <sys/sysinfo.h>
#include <argp.h>

const std::string default_name = "gpu";
static const char doc[] = "SLURM GRES config file generator";
static char args_doc[]  = "";

struct arguments {
	std::string name;
	std::string header_filename;
};

static struct argp_option options[] = {
	{"header", 'h',  "FILENAME", 0, "filename of output header"},
	{"name"  , 'n',  "NAME"    , 0, "device name"},
	{0}
};

static error_t parse_opt(
		int key,
		char* arg,
		struct argp_state *state
		) {
	auto args = reinterpret_cast<arguments*>(state->input);

	switch (key) {
	case 'h':
		args->header_filename = arg;
		break;
	case 'n':
		args->name = arg;
		break;
	default:
		return ARGP_ERR_UNKNOWN;
	}
	return 0;
}

static struct argp argp = {options, parse_opt, args_doc, doc};

int main(int argc, char** argv) {
	arguments arguments;
	arguments.name = default_name;
	arguments.header_filename = "";
	argp_parse(&argp, argc, argv, 0, 0, &arguments);

	const auto nprocs = get_nprocs();

	int ngpus;
	cudaGetDeviceCount(&ngpus);

	// Output
	if (arguments.header_filename != "") {
		std::ifstream ifs(arguments.name);
		if (!ifs) {
			std::fprintf(stderr, "[ERROR] No such file : %s\n", arguments.header_filename.c_str());
			return 1;
		}
		std::cout << ifs.rdbuf();
		ifs.close();
	}

	for (int gpu = 0; gpu < ngpus; gpu++) {
		std::printf("Name=%-10s File=/dev/nvidia%d CPUs=%d-%d\n",
				arguments.name.c_str(),
				gpu,
				(gpu * nprocs / ngpus),
				((gpu + 1) * nprocs / ngpus)
				);
	}
}
