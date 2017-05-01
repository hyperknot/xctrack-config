import codecs
import errno
import json
import os


def read_json(path):
    if not os.path.exists(path):
        raise ValueError(u'File does not exists: {}'.format(path))

    try:
        with codecs.open(path, encoding='utf-8') as infile:
            return json.loads(infile.read())

    except Exception:
        raise ValueError(u'Cannot decode json file: {}'.format(path))


def write_json(path, data):
    with codecs.open(path, 'w', encoding='utf-8') as outfile:
        json.dump(data, outfile, indent=2, ensure_ascii=False, sort_keys=True)


def ensure_dir(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise
