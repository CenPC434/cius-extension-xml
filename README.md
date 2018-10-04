# CIUS and Extension description format for EU electronic invoicing

This repository contains a machine readable XML format for describing Core
Invoice Usage Specifications (CIUS) and extensions fully compliant to the
methodology and rules of EU electronic invoicing
(EN 16931-1:2017)

* `examples/` -- folder with sample data

  `*.xml` -- sample configuration files

* `xslt` -- auxiliary transformations
  `config2html.xsl` -- XSLT transformation that can render any XML configuration file into HTML

* `schema` -- schema for CIUS and Extension configuration files 

If you find some bug or there is something missing please file a new issue.


## Details

First the compliance criteria and rules are given and second an
example is given demonstrating that this CIUS and extension description format allows
to specify a fully compliant CIUS in machine readable format.

### Compliance

The European Standard EN 16931-1:2017 "Electronic invoicing - Part 1: Semantic
datamodel of the core elements of an electronic invoice" describes the Core
Invoice Usage Specification (CIUS) as a means to comply to the core invoice
model at the specification level (see 4.4. and 7.3).


A CIUS has to meet the following criteria:

* give a clear statement on the business function or legal requirements
* give information on the publisher and governor
* give a clear statement on the difference of the core invoice model either by 
  * documenting the difference only
  * documenting all and pointing out the differences
* instances shall be fully compliant 
* shall be uniquely identifiable and may include version information
* shall give a clear statement about its underlying specifications 
* shall follow the syntax binding methodology as defined in CEN/TS 16931-3-1:201

A CIUS may specify how it creates usage guidelines and restrictions within the
core invoice model.

The following key elements of the core invoice model may be further restricted i.e. gain
higher specificity:

* **Business terms**: "A CIUS may reduce the list of conditional elements or further
specify their definition"
* **Cardinality**: "A CIUS may restrict this and consequently affect how the
receiver shall or can process the invoice instance document."
* **Semantic data type**: "Parties may want to further restrict the value domain of
a semantic data type"
* **Codes and identifiers**: "In order to support specific requiremetns the trading
partners may need to chanfe these defintions."
* **Business rules**: "Partner may need to change or add to these rules in order to
meet specific business requirements."
* **Value domain for an information element**: "Trading partners may want to
prescribe such rules where there are none or to restrict existing ones to
support specefic requirements."

Hence the following changes in reference to the core invoice model are allowed
and guaranty compliance:

* **Business terms**:
  * Mark conditional information element not to be used
  * Make semantic definition narrower
  * Add synonyms 
  * Add explanatory text
* **Cardinality**
  * Make a conditional element mandatory
  * Decrease number of repetitions
* **Semantic data type**
  * Change semantic data type from string to ...
* **Codes and identifiers**
  * Remove one of multiple defined lists
  * Mark defined values as not allowed   
* **Business rules**
  * Add new non-conflicting business for existing element(s)
  * Make an existing business rule more restrictive
* **Value domain for an information element**
  * Restrict text or byte array length
  * Require defined structured values
  * Restrict allowed fraction digits
  
  
### Compliance Example

An example showing all possible changes which are are allowed according to CEN
16931-1:2017 with fictive date is given in this [XML Instance](./examples/example-cius.xml).

A real CIUS is the [German CIUS XRechnung](./examples/example-de-cius.xml). 

    
