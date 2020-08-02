# trellis-vocabulary

[![Build Status](https://travis-ci.com/trellis-ldp/trellis-vocabulary.svg?branch=main)](https://travis-ci.com/trellis-ldp/trellis-vocabulary)

Vocabularies for the Trellis repository

This repository includes
  * The [core types](trellis.ttl) used by a Trellis repository
  * A [DOAP file](doap.ttl) describing the project itself
  * A [JSON-LD Context](trellisresource.jsonld) file used by internal data representations

The Trellis vocabulary is written in Turtle syntax. To generate RDF/XML, JSON-LD and an HTML
representation, run this script:

    python scripts/ttl2others.py trellis.ttl

