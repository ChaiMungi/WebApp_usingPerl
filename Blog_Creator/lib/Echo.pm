package Echo;
use Dancer ':syntax';
use File::Slurp qw{read_file write_file};
our $VERSION = '0.1';

get '/' => sub {
    my $file = config->{Echo}{json};
    my $json = -e $file ? read_file $file : '{}';
    my $data = from_json $json;
    
    template 'index', {data=> $data };
};


get '/' => sub {
    template 'index';
};


get '/page' => sub {
    template 'page';
};

post '/page' => sub {
    my $file = config->{Echo}{json};
    my $json = -e $file ? read_file $file : '{}';
    my $data = from_json $json;
    
    my $now = time;
    $data->{$now} = {
        title => params->{title},
        text => params->{text},
    };
    write_file $file, to_json $data;
    
    redirect '/';
};
true;
