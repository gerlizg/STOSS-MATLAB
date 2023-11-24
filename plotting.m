function plotting (option, N_ex, B_1, B_2, y_relaxation_1, y_relaxation_2, time_vector, option_2spin, T, state_1, state_2, phi_t)  

    %{
    if (flag == 0 && option_2spin == 0)
        
        values = [2, 40, 80];
        factor = [1, 0.3, 0.0035];
        
        if ismember(T, values)
            
            name2 = str(T) + 'K_exp.csv'
            data = pd.read_csv(name2, sep=';')
            data = data.astype('float32')
            data = data.values
            x_real = data[:, 0]
            y_real = data[:, 1]
            index = values.index(T)
            
            y = [((2 * x) - N_ex) for x in y]
            rmin = min(y)                       # value
            rmax = max(y)
            tmax = max(y_real)                  # target
            tmin = min(y_real)
            
            y = [(((i-rmin)/(rmax-rmin))*(tmax-tmin))+tmin for i in y]
            plt.plot(x_real, y_real, "x", markersize = 18, markeredgewidth = 6, color = b1, label = 'Experimental')
            plt.xlim([0, x_real[-1]])
        
        plt.plot(t[0:len(y)], y, color = o1, label = "Simulated")
        plt.title('%d spins at %d K (Constant Field: %.1f T)' % (N_ex, T, B[0]))
        plt.grid()
        plt.xlim([0, t[-1]])
        plt.xlabel('Time, $t$(s)') 
        plt.ylabel(u" Magnetic moment, \u03bc (emu)")
        plt.legend(loc='center right', prop={'size': 40})
        
        %}
        
                
        if (option == 0 && option_2spin == 0)
            x = time_vector (1:length(y_relaxation_1));
            figure
            plot(x, y_relaxation_1)
        
        elseif (option == 1)
            figure
            x = time_vector (1:length(y_relaxation_1));
            plot(x, y_relaxation_1, 'DisplayName', 'Simulated response')
            plot (x, B_1*-1000, 'DisplayName', 'AC field')
            xlabel('Time, (ms)')
            ylabel('mu, (a.u.)')
            
        elseif (option == 0 && option_2spin == 1)
            x = time_vector (1:length(state_1));
            tiledlayout(3,1)

            % Top plot
            nexttile
            p = plot(x, state_1, 'r', x, state_2, 'b');
            p(1).LineWidth = 2;
            p(2).LineWidth = 2;
            %plot(x, state_2, 'b', 'DisplayName', 'p*bit j')
            xlabel('Time, (ms)')
            ylabel('State')
            
            % Middle plot
            nexttile
            x = time_vector (1:length(phi_t));
            pp = plot (x, phi_t, 'b');
            pp(1).LineWidth = 2;
            %plot (x, y_relaxation_2, 'DisplayName', 'p*bit j')
            xlabel('Time, (ms)')
            ylabel('phi')

            % Bottom plot
            nexttile
            x = time_vector (1:length(y_relaxation_1));
            pp = plot (x, y_relaxation_1, 'r', x, y_relaxation_2, 'b');
            pp(1).LineWidth = 2;
            pp(2).LineWidth = 2;
            %plot (x, y_relaxation_2, 'DisplayName', 'p*bit j')
            xlabel('Time, (ms)')
            ylabel('mu, (a.u.)')
        end    
end
