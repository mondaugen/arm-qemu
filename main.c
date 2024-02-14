unsigned int n_loops = 0, n_triggers = 0;
unsigned int trigger = 1234;

void _start (void)
{
    while (1)
    {
        n_loops++;
        if (n_loops == trigger) {
            n_triggers++;
        }
    }
}
