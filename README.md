# Droplr's JMeter Docker Image

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/Droplr/docker-jmeter/master/LICENSE)

Easily run JMeter tests without installing Java on your machine.
Image contains superb useful JMeter plugins provided by https://jmeter-plugins.org/.

## Usage

To run sample stress test...

```
$ docker run -v $(pwd):/jmeter -t droplr/jmeter -n -t examples/scenario-stress.jmx -Jcsv examples/urls.csv -l results.jtl
```

To view results in GUI, you must have JMeter installed locally.

## Example scenarios

Scenarios uses CSV of URLs to test (examples/urls.csv).

* examples/scenario-stress.jmx - step-by-step increases number of threads up to 100
* examples/scenario-load.jmx - generates constant load on your urls

### Format of URLs file

```
GroupName,Protocol,Host,Path
```

## Caveats

### Clean old results before starting new test

You have to remove old results file, otherwise JMeter will append results of the new test-run to it.

```
rm results.jtl
```
