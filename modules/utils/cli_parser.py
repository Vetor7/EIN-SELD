import argparse
import sys
from pathlib import Path

from ruamel.yaml import YAML
from termcolor import cprint


def parse_cli_overides():
    
    parser = argparse.ArgumentParser(
        description='Event Independent Network for Sound Event Localization and Detection.', 
        add_help=False
    )
    parser.add_argument('-c', '--config_file', help='Specify config file', metavar='FILE')
    subparsers = parser.add_subparsers(dest='mode')
    parser_preproc = subparsers.add_parser('preprocess')
    parser_train = subparsers.add_parser('train')
    parser_infer = subparsers.add_parser('infer')
    subparsers.add_parser('evaluate')

    # Require the user to specify a sub-command
    subparsers.required = True
    parser_preproc.add_argument('--preproc_mode', choices=['extract_data', 'extract_scalar', 'extract_meta'],
                                required=True, help='select preprocessing mode')
    parser_preproc.add_argument('--dataset_type', default='dev', choices=['dev', 'eval', 'test'], 
                                help='select dataset to preprocess')
    parser_preproc.add_argument('--num_workers', type=int, default=8, metavar='N')
    parser_preproc.add_argument('--no_cuda', action='store_true', help='Do not use cuda.')
    parser_train.add_argument('--seed', type=int, default=2020, metavar='N')
    parser_train.add_argument('--num_workers', type=int, default=8, metavar='N')
    parser_train.add_argument('--read_into_mem', action='store_true', help='Read dataloader into memory')
    parser_train.add_argument('--no_cuda', action='store_true', help='Do not use cuda.')
    parser_infer.add_argument('--num_workers', type=int, default=8, metavar='N')
    parser_infer.add_argument('--read_into_mem', action='store_true')
    parser_infer.add_argument('--no_cuda', action='store_true', help='Do not use cuda.')

    args = parser.parse_args()
    args_dict = vars(args)
    cprint("Args:", "green")
    for key, value in args_dict.items():
        print(f"     {key:25s} -> {value}")

    yaml = YAML()
    yaml.indent(mapping=4, sequence=6, offset=3)
    yaml.default_flow_style = False
    with open(args.config_file, 'r') as f:
        cfg = yaml.load(f)
    cprint("Cfg:", "red")
    yaml.dump(cfg, sys.stdout, transform=replace_indent)

    return args, cfg

def replace_indent(stream):
    stream = "     " + stream
    return stream.replace("\n", "\n     ")
