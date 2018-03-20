import os
import pandas as pd
from copy import copy
import numpy as np

import nibabel

base_dir = '/Users/kristadestasio/Desktop/sub-REV051'

# walk around and get all our files
walker = os.walk(base_dir)
files = [os.path.join(path, fn) for path, dirs, files in walker for fn in files]
files = [f for f in files if not f.endswith('.DS_Store')]

# split the first file by the path seperator, and get the first meaningful part of the path (ie. subject ID)
sub_ind = [i for i, substr in enumerate(files[0].split(os.sep)) if substr.startswith('sub')][0]

splitfiles = [f.split(os.sep)[sub_ind:] for f in files]

split_filenames = [fn[-1].split('_') for fn in splitfiles]


clean_split = []
for fn in copy(split_filenames):
    # some files only have one run, and thus don't have 'run' in the filename, fix those first
    if not any([substring.startswith('run') for substring in fn]):
        if len(fn) == 3:
            fn.insert(2, 'run-01')
        elif len(fn) == 4:
            fn.insert(3, 'run-01')

    # add a 'type' column, depending on the filetype
    if fn[2].startswith('run') and fn[-1].startswith('T1'):
        fn.insert(2,None)
        fn.insert(2,'anatomical')
    elif fn[2].startswith('run'): # TODO: filter only acceptable fieldmap names
        fn.insert(2, None)
        fn.insert(2, 'field_map')
    elif fn[2].startswith('task'):
        task_name = fn[2].split('-')[-1]
        fn[2] = task_name
        fn.insert(2,'functional')
    else:
        continue

    # remove stuff that will be knowable in the column name
    fn[1] = fn[1].strip('ses-wave')
    fn[0] = fn[0].strip('sub-')
    fn[4] = fn[4].strip('run-')

    clean_split.append(fn)


# subject, session, type (anatomical/fieldmap/function), task_name, run, filename
fn_df = pd.DataFrame(clean_split, columns=["subject", "session", "type", "task", "run", "filename"])
fn_df['full_path'] = files

# set data types explicitly
fn_df['run'] = fn_df['run'].astype(np.int)

# for generating list of expected filenames, something like this...
def gen_files(run_n):
    files = ["magnitude{}".format(i) for i in range(run_n)]





for f in files:
    files[0].split(os.sep)

#
# def clean_filename(fn, i):
#     if fn[i].startswith('run') and fn[-1].startswith('T1'):
#         fn.insert(i,None)
#         fn.insert(i,'anatomical')
#     elif fn[i].startswith('run'):
#         fn.insert(i, None)
#         fn.insert(i, 'field_map')
#     elif fn[i].startswith('task'):
#         task_name = fn[i].split('-')[-1]
#         fn.insert(i,task_name)
#         fn.insert(i,'functional')
#     return fn
#
# def find_ind(longstring, start_substring):
#     try:
#         if isinstance(longstring, list):
#             sub_ind = [i for i, substr in enumerate(longstring) if substr.startswith(start_substring)][0]
#         elif isinstance(longstring, str):
#             sub_ind = [i for i, substr in enumerate(longstring.split(os.sep)) if substr.startswith(start_substring)][0]
#         return sub_ind
#     except IndexError:
#         #print('No substrings starting with {} found'.format(start_substring))
#         return False
#
#

