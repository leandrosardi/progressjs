# Progress.js

The **Progress.Js** is a JavaScript library to process a large pool of AJAX calls the right way, without fall on bad-practicess like 

- launching many AJAX calls in parallel; or

- recursive AJAX calls.

You can find examples of the bad practicess listed above [here](#6-appendix-progressjs-internals).

Additionally, you can query the status of the progress on the run, in order to update user interface elements like a progress-bar or a progress-counter.

*(pending)* You can find a [live example](https://connectionsphere.com/developers/progressjs) of **Progress.Js** here: [https://connectionsphere.com/developers/progressjs](https://connectionsphere.com/developers/progressjs)



# 1. Getting Started
Get started in 3 simple steps.

1. Download the required libraries and stylesheets.
All these files are included in this project. You can download them from this page.

2. Include them in the <header> section of your HTML page.

```html
<script src="jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="commons.js" type="text/javascript"></script>
<link rel="stylesheet" href="./templates.css">
<script src="./progress.min.js" type="text/javascript"></script>
```

3. Create the progress bar.

```html
<input type='button' id='start' value='start' />
<script>
    $(document).ready(function() {
        $('#start').click(function() {
            // returns an unique-identifier (a.k.a. handler) code to handle this pool of AJAX calls.
            handler = progressJs.start({
                url: './superhero_secret.json', // URL to send an AJAX POST call at every step of the progress.
    			type: 'GET', 
                datas: [ // Array of hashes. Each hash is the data to send to the access point at every step of the progress.
                    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
                    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
                    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
                ]
            });
        })
    });
</script>
```

*(pending to add screesnhot here)*

# 2. Cancelling Process

```html
<script>
    progressJs.cencel(handler);
</script>
```

# 3. Getting the Progress Status

```html
<script>
    console.log('count:' + progressJs.count(handler)); // number of AJAX calls requested
    console.log('completed:' + progressJs.completed(handler)); // number of AJAX calls completed
    console.log('failed:' + progressJs.failed(handler)); // number of AJAX calls failed due a communication issue. This method is not to handle the responses from the access point reoprting any issue at the server side.
</script>
```

# 4. Event Handling

## 4.1. Catching AJAX Call Completion

Catching when each AJAX call has been completed successfully.

```html
<input type='button' id='start' value='start' />
<script>
	$(document).ready(function() {
        $('#start').click(function() {
            // returns an unique-identifier (a.k.a. handler) code to handle this pool of AJAX calls.
            handler = progressJs.start({
                url: './superhero_secret_wrong_url.json', // URL to send an AJAX POST call at every step of the progress.
                datas: [ // Array of hashes. Each hash is the data to send to the access point at every step of the progress.
                    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
                    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
                    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
                ],
                success: function(j,data) {
                    // j is the index in the array of data hashes.

                    // result,status,xhr are the parameters returned the standard AJAX library.
                    // Example:
                    // https://github.com/leandrosardi/tempora/blob/1.6.1/views/remote/dashboard.erb#L412

                    // update any element in your HTML to show the progress.
                }
            });
        })
	});
</script>
```

## 4.2. Catching AJAX Call Failure

Catching when one AJAX call has failed because a communication problem.

**Note:** The processing of the further AJAX calls is interrumped when one failure happens.

```html
<input type='button' id='start' value='start' />
<script>
    $(document).ready(function() {
        $('#start').click(function() {
            // returns an unique-identifier (a.k.a. handler) code to handle this pool of AJAX calls.
                handler = progressJs.start({
                url: './superhero_secret_wrong_url.json', // URL to send an AJAX POST call at every step of the progress.
                datas: [ // Array of hashes. Each hash is the data to send to the access point at every step of the progress.
                    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
                    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
                    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
                ],
                error: function(j, data) {
                    // j is the index in the array of data hashes.

                    // result,status,xhr are the parameters returned the standard AJAX library.
                    // Example:
                    // https://github.com/leandrosardi/tempora/blob/1.6.1/views/remote/dashboard.erb#L481

                    // The processing of AJAX calls has been interrumped, because one ajax call has failed.
                    // Report this issue in the screens.
                }
            });
        })
    });
</script>
```

# 5. Appendix: Progress.Js Internals

Here are 2 examples about 2 wrong ways about how to run a pool of AJAX calls.
Finally, at the end, there is an example of the right way to do it.

## 5.1. Wrong Way 1: Launching Many AJAX Calls in Parallel

This appreach generates an overload at the server side.

**Example:**

```javascript
function submitData(data) {
	return $.ajax({
		url: './superhero_secret.json',
		type: 'GET',
		data: data,
	});
}

// Array of hashes. Each hash is the data to send to the access point at every step of the progress.
array_of_data_to_submit = [ 
    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
]

// Call the AJAX
array_of_data_to_submit.forEach(submitData);
```

## 5.2. Wrong Way 2: Recursive AJAX Calls 

This appreach generates an overload at the client side (the browser).

**Example:**

```javascript
function submitData(j) {
	return $.ajax({
		url: './superhero_secret.json',
		type: 'GET',
		data: array_of_data_to_submit[j],
		success: function(result,status,xhr) {
			if ( j < array_of_data_to_submit.size ) { 
				setTimeout( function() { submitData(j+1) }, 5);
			} else {
                // We have done with the array.
			}	
		}
	});
}

// Array of hashes. Each hash is the data to send to the access point at every step of the progress.
array_of_data_to_submit = [ 
    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
]

// Call the 
submitData(0);
```

## 5.3. The Right Way

Performing the AJAX calls one by one, using a global semaphore variable

```javascript
var i = 0;

function submitData(data, j) {
    // loop until it is the time to process the AJAX number j.
	while (i<j) { 
        setTimeout(function() {
            console.log('waiting i=='+j.toString());
        }, 1000);
    }
    return $.ajax({
		url: './superhero_secret.json',
		type: 'GET',
		data: data,
		success: function(result,status,xhr) {
			i += 1;	
		},
		error: function(result,status,xhr) {
		    // inform process cancelation and error description	
		},
	});
}

function submitBulkData(array_of_data_to_submit) {
    array_of_data_to_submit.forEach(submitData);
}

submitBulkData([ 
    { first_name: 'Clark', last_name: 'Kent', role: 'Superman' }, 
    { first_name: 'Bruce', last_name: 'Wayne', role: 'Batman' }, 
    { first_name: 'Peter', last_name: 'Parker', role: 'Spiderman' }, 
]);
```


# Additional Notes
The **Filters.Js** is used at [**ExpandedVenture**](https://expandedventure.com/expandedventure) to develop different UI/UX features.

The **Filters.Js** library is just starting on Jun-2021, and more functions will be added as needed.

The **Filters.Js** library has been written following the [**W3C JavaScript Best Practices**](https://www.w3.org/community/webed/wiki/JavaScript_best_practices).

# Disclaimer
Use at your own risk. The use of the software and scripts downloaded on this site is done at your own discretion and risk and with agreement that you will be solely responsible for any damage to any computer system or loss of data that results from such activities.

# Maintainer
Leandro Daniel Sardi <leandro((dot))sardi((@))expandedventure.com>


